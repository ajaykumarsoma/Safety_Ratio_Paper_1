#!/bin/bash

# Run all experiments to reproduce SPCOM 2026 paper results
# Estimated runtime: 30-45 minutes on CPU

set -e  # Exit on error

echo "=========================================="
echo "Safety Ratio Research - Full Reproduction"
echo "=========================================="
echo ""
echo "This will run all experiments and generate all results."
echo "Estimated time: 30-45 minutes on CPU"
echo ""
read -p "Continue? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi
echo ""

# Activate virtual environment
echo "Activating virtual environment..."
source /Users/amac/MechInterpLab/venv/bin/activate
echo "✅ Activated"
echo ""

# Track start time
start_time=$(date +%s)

# Step 1: Generate dataset
echo "=========================================="
echo "Step 1/8: Generating 301-prompt dataset"
echo "=========================================="
python scripts/01_generate_dataset.py
echo "✅ Dataset generated"
echo ""

# Step 2: Run Qwen experiment
echo "=========================================="
echo "Step 2/8: Running Qwen2.5-1.5B experiment"
echo "=========================================="
echo "(This takes ~15-20 minutes...)"
python scripts/02_run_qwen_experiment.py
echo "✅ Qwen experiment complete"
echo ""

# Step 3: Run GPT-2 experiments
echo "=========================================="
echo "Step 3/8: Running GPT-2 experiments"
echo "=========================================="
echo "(This takes ~10-15 minutes...)"
python scripts/03_run_gpt2_experiments.py
echo "✅ GPT-2 experiments complete"
echo ""

# Step 4: Layer ablation
echo "=========================================="
echo "Step 4/8: Running layer ablation study"
echo "=========================================="
echo "(This takes ~15-20 minutes...)"
python scripts/04_layer_ablation.py
echo "✅ Layer ablation complete"
echo ""

# Step 5: Baseline comparison
echo "=========================================="
echo "Step 5/8: Comparing SR vs Perplexity"
echo "=========================================="
python scripts/05_baseline_comparison.py
echo "✅ Baseline comparison complete"
echo ""

# Step 6: Statistical analysis
echo "=========================================="
echo "Step 6/8: Computing statistical tests"
echo "=========================================="
python scripts/06_statistical_analysis.py
echo "✅ Statistical analysis complete"
echo ""

# Step 7: Generate figures
echo "=========================================="
echo "Step 7/8: Generating paper figures"
echo "=========================================="
python scripts/07_generate_figures.py
echo "✅ Figures generated"
echo ""

# Step 8: Train/val/test split analysis
echo "=========================================="
echo "Step 8/8: Analyzing train/val/test splits"
echo "=========================================="
python scripts/08_train_val_test_split.py
echo "✅ Split analysis complete"
echo ""

# Calculate elapsed time
end_time=$(date +%s)
elapsed=$((end_time - start_time))
minutes=$((elapsed / 60))
seconds=$((elapsed % 60))

echo "=========================================="
echo "✅ ALL EXPERIMENTS COMPLETE!"
echo "=========================================="
echo ""
echo "Total time: ${minutes}m ${seconds}s"
echo ""
echo "📂 Results saved to:"
echo "  - data/           (datasets)"
echo "  - results/        (CSV files)"
echo "  - ../figures/     (PNG figures)"
echo ""
echo "📊 Key results:"
echo "  - Adversarial recall: Check results/qwen_results_301.csv"
echo "  - Statistical tests: Check results/statistical_tests.csv"
echo "  - Layer ablation: Check results/layer_ablation_metrics.csv"
echo "  - Baseline comparison: Check results/baseline_comparison_metrics.csv"
echo ""
echo "📈 Figures:"
echo "  - ../figures/publication_figure_main.png"
echo "  - ../figures/three_pillars_analysis_300prompts.png"
echo "  - ../figures/multi_model_comparison.png"
echo "  - ../figures/baseline_comparison.png"
echo ""
echo "=========================================="
echo ""
echo "To view results:"
echo "  cd results && ls -lh"
echo ""
echo "To view figures:"
echo "  cd ../figures && open ."
echo ""
echo "=========================================="

