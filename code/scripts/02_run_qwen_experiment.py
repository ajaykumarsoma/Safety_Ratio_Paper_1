#!/usr/bin/env python3
"""
Run Qwen2.5-1.5B Safety Ratio experiment on 301 prompts.

Computes:
- Sentinel activation (Layer 0 MLP max)
- Engine activation (max over Layers 2-4 MLP)
- Safety Ratio (Sentinel / Engine)
- Perplexity (next-token prediction confidence)

Output:
- results/qwen_results_301.csv
"""

import torch
import pandas as pd
import numpy as np
from transformer_lens import HookedTransformer
from pathlib import Path
import warnings
warnings.filterwarnings('ignore')


def calculate_safety_ratio(model, prompt, sentinel_layer=0, engine_layers=[2, 3, 4]):
    """Calculate Safety Ratio for a single prompt.
    
    Args:
        model: HookedTransformer model
        prompt: Input text
        sentinel_layer: Layer for grounding (default: 0)
        engine_layers: Layers for semantic processing (default: [2,3,4])
    
    Returns:
        dict with sentinel_activation, engine_activation, safety_ratio, perplexity
    """
    tokens = model.to_tokens(prompt)
    logits, cache = model.run_with_cache(tokens)
    
    # Sentinel activation (Layer 0 MLP)
    sentinel_mlp = cache[f"blocks.{sentinel_layer}.mlp.hook_post"]
    sentinel_max = sentinel_mlp.abs().max().item()
    
    # Engine activations (Layers 2-4 MLP)
    engine_max = 0.0
    for layer in engine_layers:
        engine_mlp = cache[f"blocks.{layer}.mlp.hook_post"]
        layer_max = engine_mlp.abs().max().item()
        engine_max = max(engine_max, layer_max)
    
    # Safety Ratio
    safety_ratio = sentinel_max / engine_max if engine_max > 0 else float('inf')
    
    # Perplexity (next-token prediction)
    next_token_logits = logits[0, -1, :]
    next_token_probs = torch.softmax(next_token_logits, dim=-1)
    top_prob = next_token_probs.max()
    perplexity = -torch.log(top_prob).item()
    
    return {
        'sentinel_activation': sentinel_max,
        'engine_activation': engine_max,
        'safety_ratio': safety_ratio,
        'perplexity': perplexity
    }


def main():
    print("="*80)
    print("Running Qwen2.5-1.5B Safety Ratio Experiment")
    print("="*80)
    print()
    
    # Load prompts
    print("Loading prompts...")
    df_prompts = pd.read_csv("data/prompts_301.csv")
    print(f"✅ Loaded {len(df_prompts)} prompts")
    print(f"   - Truth: {len(df_prompts[df_prompts['category']=='truth'])}")
    print(f"   - Nonsense: {len(df_prompts[df_prompts['category']=='nonsense'])}")
    print(f"   - Adversarial: {len(df_prompts[df_prompts['category']=='adversarial'])}")
    print()
    
    # Load model
    print("Loading Qwen2.5-1.5B-Instruct on CPU...")
    print("(This may take 1-2 minutes...)")
    model = HookedTransformer.from_pretrained("Qwen/Qwen2.5-1.5B-Instruct", device="cpu")
    print(f"✅ Model loaded: {model.cfg.n_layers} layers, d_mlp={model.cfg.d_mlp}")
    print()
    
    # Run experiment
    print("Computing Safety Ratios...")
    print("(This takes ~15-20 minutes on CPU)")
    print()
    
    results = []
    total = len(df_prompts)
    
    for idx, row in df_prompts.iterrows():
        prompt = row['prompt']
        category = row['category']
        
        # Progress indicator
        if (idx + 1) % 25 == 0 or idx == 0 or (idx + 1) == total:
            preview = (prompt[:60] + "...") if len(prompt) > 60 else prompt
            print(f"  [{idx+1:3d}/{total}] {preview}")
        
        # Calculate SR
        result = calculate_safety_ratio(model, prompt)
        result['prompt'] = prompt
        result['category'] = category
        result['model'] = 'Qwen2.5-1.5B-Instruct'
        
        results.append(result)
    
    # Save results
    df_results = pd.DataFrame(results)
    
    Path("results").mkdir(exist_ok=True)
    output_path = "results/qwen_results_301.csv"
    df_results.to_csv(output_path, index=False)
    
    print()
    print("="*80)
    print("✅ Experiment Complete!")
    print("="*80)
    print()
    print(f"Results saved to: {output_path}")
    print()
    print("Summary Statistics:")
    print()
    
    for category in ['truth', 'nonsense', 'adversarial']:
        cat_data = df_results[df_results['category'] == category]
        sr_mean = cat_data['safety_ratio'].mean()
        sr_std = cat_data['safety_ratio'].std()
        print(f"{category.capitalize():12s}: SR = {sr_mean:.4f} ± {sr_std:.4f}")
    
    print()
    print("Next steps:")
    print("  - Run GPT-2 experiments: python scripts/03_run_gpt2_experiments.py")
    print("  - Generate figures: python scripts/07_generate_figures.py")
    print()


if __name__ == "__main__":
    main()

