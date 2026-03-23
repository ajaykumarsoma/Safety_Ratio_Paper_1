# ⚡ Quick Start - Safety Ratio Reproducibility Package

## 🎯 Goal
Reproduce all results from the SPCOM 2026 paper in **under 5 minutes** using pre-computed data.

---

## 📦 Option A: Use Pre-Computed Results (Recommended - 2 minutes)

This copies all experimental results from the parent directory so you don't need to re-run expensive experiments.

```bash
cd /Users/amac/MechInterpLab/MI-Experiments/ieee_paper/code

# Activate virtual environment
source /Users/amac/MechInterpLab/venv/bin/activate

# Copy pre-computed results
python scripts/00_copy_existing_data.py
```

**Output:**
- ✅ `data/prompts_301.csv` - Full 301-prompt dataset
- ✅ `results/qwen_results_301.csv` - Qwen2.5-1.5B results
- ✅ `results/gpt2_small_results_301.csv` - GPT-2 Small results
- ✅ `results/gpt2_medium_results_301.csv` - GPT-2 Medium results
- ✅ `results/layer_ablation_metrics.csv` - Ablation study
- ✅ `results/baseline_comparison_metrics.csv` - SR vs Perplexity
- ✅ `results/statistical_tests.csv` - t-tests, Cohen's d, p-values
- ✅ `../figures/*.png` - All paper figures

**Verify results:**
```bash
# View key metrics
cat results/statistical_tests.csv

# View adversarial detection performance
python -c "import pandas as pd; df = pd.read_csv('results/qwen_results_301.csv'); adv = df[df['category']=='adversarial']['safety_ratio']; threshold = adv.quantile(0.95); recall = (adv < threshold).mean(); print(f'Adversarial Recall: {recall*100:.1f}%')"

# View figures
open ../figures/publication_figure_main.png
```

---

## 🔬 Option B: Reproduce From Scratch (30-45 minutes)

This re-runs all experiments from scratch. **Warning:** Takes 30-45 minutes on CPU.

```bash
cd /Users/amac/MechInterpLab/MI-Experiments/ieee_paper/code

# Setup environment (first time only)
./setup.sh

# Run all experiments
./run_all_experiments.sh
```

This will:
1. Generate 301-prompt dataset
2. Run Qwen2.5-1.5B experiment (~15-20 min)
3. Run GPT-2 Small/Medium experiments (~10-15 min)
4. Perform layer ablation study (~15-20 min)
5. Compare SR vs Perplexity baseline
6. Compute statistical tests
7. Generate all figures
8. Analyze train/val/test splits

---

## 📊 Expected Results

After running either option, you should see:

### **Key Metrics**

| Metric | Expected Value | File |
|--------|----------------|------|
| Adversarial Recall (Qwen) | ~95% | `results/qwen_results_301.csv` |
| False Positive Rate | ~70% | `results/qwen_results_301.csv` |
| SR vs PPL Recall Ratio | ~2.16× | `results/baseline_comparison_metrics.csv` |
| p-value (Truth vs Adv) | 0.0052 | `results/statistical_tests.csv` |
| Cohen's d | 0.40 | `results/statistical_tests.csv` |

### **Verify Adversarial Recall**

```bash
python -c "
import pandas as pd
df = pd.read_csv('results/qwen_results_301.csv')
adv = df[df['category']=='adversarial']['safety_ratio']
threshold = adv.quantile(0.95)
recall = (adv < threshold).mean()
print(f'Threshold: {threshold:.4f}')
print(f'Adversarial Recall: {recall*100:.1f}%')
print(f'Expected: ~95%')
"
```

### **View Figures**

```bash
# Main 6-panel figure (Figure 1 in paper)
open ../figures/publication_figure_main.png

# Architecture diagram (Figure 2)
open ../figures/three_pillars_analysis_300prompts.png

# Cross-model comparison
open ../figures/multi_model_comparison.png

# SR vs Perplexity ROC curves
open ../figures/baseline_comparison.png
```

---

## 🔍 Inspect Data

```bash
# View first 10 prompts
head -n 11 data/prompts_301.csv

# Count prompts by category
python -c "import pandas as pd; df = pd.read_csv('data/prompts_301.csv'); print(df['category'].value_counts())"

# View Qwen results summary
python -c "import pandas as pd; df = pd.read_csv('results/qwen_results_301.csv'); print(df.groupby('category')['safety_ratio'].describe())"

# View statistical tests
cat results/statistical_tests.csv
```

---

## ✅ Verification Checklist

- [ ] `data/prompts_301.csv` exists (301 rows)
- [ ] `results/qwen_results_301.csv` exists (301 rows)
- [ ] Adversarial recall ≈ 95%
- [ ] p-value ≈ 0.0052 in `results/statistical_tests.csv`
- [ ] `../figures/publication_figure_main.png` exists

---

## 🐛 Troubleshooting

**Issue: "No such file or directory: data/prompts_301.csv"**
```bash
python scripts/00_copy_existing_data.py
```

**Issue: "ModuleNotFoundError: No module named 'transformer_lens'"**
```bash
source /Users/amac/MechInterpLab/venv/bin/activate
pip install transformer-lens pandas numpy scipy matplotlib seaborn
```

**Issue: Figures not found**
```bash
ls -lh ../figures/
# If empty, copy from parent:
cp ../../*.png ../figures/
```

---

## 📧 Questions?

See full documentation in `README.md`

---

**Ready? Run Option A to get results in 2 minutes!** 🚀

