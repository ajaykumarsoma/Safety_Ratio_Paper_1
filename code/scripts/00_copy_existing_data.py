#!/usr/bin/env python3
"""
Copy existing experimental data from parent directory to code/data and code/results.

This script copies the actual 301-prompt dataset and results that were used
in the paper, so you don't need to re-run the expensive experiments.

If you want to reproduce from scratch, skip this script and run:
  01_generate_dataset.py
  02_run_qwen_experiment.py
  etc.
"""

import shutil
import pandas as pd
from pathlib import Path


def main():
    print("="*80)
    print("Copying Existing Experimental Data")
    print("="*80)
    print()
    print("This copies pre-computed results from the parent directory.")
    print("Use this to skip expensive re-computation (recommended).")
    print()
    
    # Create directories
    Path("data").mkdir(exist_ok=True)
    Path("results").mkdir(exist_ok=True)
    
    copied_files = []
    
    # Copy dataset
    source_data = "../../safety_ratio_results_300.csv"
    if Path(source_data).exists():
        df = pd.read_csv(source_data)
        
        # Extract prompts
        df_prompts = df[['prompt', 'category']].drop_duplicates().reset_index(drop=True)
        df_prompts['prompt_id'] = df_prompts.apply(
            lambda row: f"{row['category']}_{df_prompts[df_prompts['category']==row['category']].index.tolist().index(row.name):03d}",
            axis=1
        )
        df_prompts.to_csv("data/prompts_301.csv", index=False)
        print(f"✅ Copied prompts: data/prompts_301.csv ({len(df_prompts)} prompts)")
        copied_files.append("data/prompts_301.csv")
        
        # Copy full results
        shutil.copy(source_data, "results/qwen_results_301.csv")
        print(f"✅ Copied Qwen results: results/qwen_results_301.csv")
        copied_files.append("results/qwen_results_301.csv")
    else:
        print(f"⚠️  Not found: {source_data}")
    
    # Copy GPT-2 results
    for model_name in ["gpt2_small", "gpt2_medium"]:
        source_file = f"../../safety_ratio_results_300_{model_name}.csv"
        dest_file = f"results/{model_name}_results_301.csv"
        if Path(source_file).exists():
            shutil.copy(source_file, dest_file)
            print(f"✅ Copied {model_name} results: {dest_file}")
            copied_files.append(dest_file)
        else:
            print(f"⚠️  Not found: {source_file}")
    
    # Copy other results
    result_files = [
        ("../../qwen_layer_ablation_metrics.csv", "results/layer_ablation_metrics.csv"),
        ("../../baseline_comparison_metrics.csv", "results/baseline_comparison_metrics.csv"),
        ("../../statistical_tests.csv", "results/statistical_tests.csv"),
        ("../../confidence_intervals.csv", "results/confidence_intervals.csv"),
    ]
    
    for source, dest in result_files:
        if Path(source).exists():
            shutil.copy(source, dest)
            print(f"✅ Copied: {dest}")
            copied_files.append(dest)
        else:
            print(f"⚠️  Not found: {source}")
    
    # Copy figures
    Path("../figures").mkdir(exist_ok=True)
    figure_files = [
        ("../../publication_figure_main.png", "../figures/publication_figure_main.png"),
        ("../../three_pillars_analysis_300prompts.png", "../figures/three_pillars_analysis_300prompts.png"),
        ("../../multi_model_comparison.png", "../figures/multi_model_comparison.png"),
        ("../../baseline_comparison.png", "../figures/baseline_comparison.png"),
    ]
    
    for source, dest in figure_files:
        if Path(source).exists():
            shutil.copy(source, dest)
            print(f"✅ Copied figure: {dest}")
            copied_files.append(dest)
        else:
            print(f"⚠️  Not found: {source}")
    
    print()
    print("="*80)
    print(f"✅ Copied {len(copied_files)} files")
    print("="*80)
    print()
    print("You can now:")
    print("  1. View results: ls -lh results/")
    print("  2. View figures: ls -lh ../figures/")
    print("  3. Run analysis scripts: python scripts/06_statistical_analysis.py")
    print()
    print("To reproduce from scratch instead:")
    print("  1. Delete data/ and results/ folders")
    print("  2. Run: ./run_all_experiments.sh")
    print()


if __name__ == "__main__":
    main()

