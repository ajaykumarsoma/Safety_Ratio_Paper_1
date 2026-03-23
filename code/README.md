# 🔬 Safety Ratio Research - Reproducible Code

This folder contains all code, data, and scripts to reproduce the results in the SPCOM 2026 paper:

**"The Safety Ratio: Quantifying Grounding vs Confidence Decoupling in Autoregressive Transformers"**

---

## 📁 Folder Structure

```
code/
├── README.md                    # This file
├── requirements.txt             # Python dependencies
├── setup.sh                     # One-command setup script
├── run_all_experiments.sh       # Run all experiments (reproduces all results)
│
├── scripts/                     # Python scripts (numbered in execution order)
│   ├── 01_generate_dataset.py          # Generate 301-prompt dataset
│   ├── 02_run_qwen_experiment.py       # Main Qwen2.5-1.5B experiment
│   ├── 03_run_gpt2_experiments.py      # GPT-2 Small/Medium experiments
│   ├── 04_layer_ablation.py            # Layer selection ablation study
│   ├── 05_baseline_comparison.py       # SR vs Perplexity baseline
│   ├── 06_statistical_analysis.py      # Statistical tests & metrics
│   ├── 07_generate_figures.py          # Create all paper figures
│   └── 08_train_val_test_split.py      # 60/20/20 split analysis
│
├── data/                        # Generated datasets
│   ├── prompts_301.csv                 # Full 301-prompt dataset
│   ├── prompts_train.csv               # Training split (180 prompts)
│   ├── prompts_val.csv                 # Validation split (60 prompts)
│   └── prompts_test.csv                # Test split (61 prompts)
│
├── results/                     # Experimental results (CSV files)
│   ├── qwen_results_301.csv            # Qwen2.5-1.5B results
│   ├── gpt2_small_results_301.csv      # GPT-2 Small results
│   ├── gpt2_medium_results_301.csv     # GPT-2 Medium results
│   ├── layer_ablation_metrics.csv      # Ablation study results
│   ├── baseline_comparison_metrics.csv # SR vs Perplexity metrics
│   ├── statistical_tests.csv           # t-tests, effect sizes, CIs
│   └── split_metrics.csv               # Train/val/test metrics
│
└── notebooks/                   # Jupyter notebooks (optional)
    └── exploratory_analysis.ipynb      # Interactive exploration
```

---

## 🚀 Quick Start (3 Commands)

### **Option A: Run Everything (Recommended)**

```bash
cd code
./setup.sh              # Install dependencies (1 minute)
./run_all_experiments.sh  # Run all experiments (30-45 minutes on CPU)
```

This will:
1. Generate the 301-prompt dataset
2. Run Qwen2.5-1.5B experiment
3. Run GPT-2 Small/Medium experiments
4. Perform layer ablation study
5. Compare SR vs Perplexity baseline
6. Compute all statistical tests
7. Generate all paper figures
8. Perform train/val/test split analysis

**Output:** All results in `results/` and figures in `../figures/`

---

### **Option B: Run Individual Scripts**

```bash
cd code
source ../../../venv/bin/activate  # Activate virtual environment

# Step 1: Generate dataset
python scripts/01_generate_dataset.py

# Step 2: Run main experiment
python scripts/02_run_qwen_experiment.py

# Step 3: Generate figures
python scripts/07_generate_figures.py
```

---

## 📊 Expected Results

After running all experiments, you should see:

### **Key Metrics (from paper)**

| Metric | Value | Location |
|--------|-------|----------|
| **Adversarial Recall (Qwen)** | 95% | `results/qwen_results_301.csv` |
| **False Positive Rate** | 70% | `results/qwen_results_301.csv` |
| **SR vs PPL Recall Ratio** | 2.16× | `results/baseline_comparison_metrics.csv` |
| **p-value (Truth vs Adv)** | 0.0052 | `results/statistical_tests.csv` |
| **Cohen's d** | 0.40 | `results/statistical_tests.csv` |
| **Best Layer Config** | L0 / L2-4 | `results/layer_ablation_metrics.csv` |

### **Generated Figures**

All figures will be saved to `../figures/`:

1. `publication_figure_main.png` - Main 6-panel figure (Figure 1 in paper)
2. `three_pillars_analysis_300prompts.png` - Architecture diagram (Figure 2)
3. `multi_model_comparison.png` - Cross-model comparison
4. `baseline_comparison.png` - SR vs Perplexity ROC curves

---

## 🔧 System Requirements

- **OS:** macOS, Linux, or Windows (WSL)
- **Python:** 3.9+
- **RAM:** 8GB minimum (16GB recommended)
- **Disk:** 5GB free space
- **CPU:** Any modern CPU (no GPU required)
- **Time:** 30-45 minutes for full reproduction

---

## 📦 Dependencies

See `requirements.txt` for full list. Key packages:

- `transformer-lens==1.14.0` - Model analysis
- `torch==2.0.0` - PyTorch
- `pandas==2.0.0` - Data manipulation
- `numpy==1.24.0` - Numerical computing
- `scipy==1.10.0` - Statistical tests
- `matplotlib==3.7.0` - Plotting
- `seaborn==0.12.0` - Statistical visualization

---

## 📝 Script Descriptions

### **01_generate_dataset.py**
- Generates 301 prompts (102 truth, 99 nonsense, 100 adversarial)
- Creates train/val/test splits (60/20/20)
- Output: `data/prompts_301.csv`, `data/prompts_{train,val,test}.csv`

### **02_run_qwen_experiment.py**
- Loads Qwen2.5-1.5B-Instruct
- Computes Safety Ratio for all 301 prompts
- Uses Layer 0 (Sentinel) and Layers 2-4 (Engine)
- Output: `results/qwen_results_301.csv`

### **03_run_gpt2_experiments.py**
- Runs same analysis on GPT-2 Small and GPT-2 Medium
- Uses same layer choices (L0 / L2-4)
- Output: `results/gpt2_{small,medium}_results_301.csv`

### **04_layer_ablation.py**
- Tests 5 different Sentinel/Engine layer combinations
- Reports recall and FPR for each configuration
- Output: `results/layer_ablation_metrics.csv`

### **05_baseline_comparison.py**
- Compares SR vs Perplexity for adversarial detection
- Computes ROC curves and matched-FPR metrics
- Output: `results/baseline_comparison_metrics.csv`

### **06_statistical_analysis.py**
- Performs t-tests (Truth vs Adversarial, etc.)
- Computes Cohen's d effect sizes
- Calculates 95% confidence intervals
- Output: `results/statistical_tests.csv`

### **07_generate_figures.py**
- Creates all paper figures
- Generates publication-quality PNGs (300 DPI)
- Output: `../figures/*.png`

### **08_train_val_test_split.py**
- Validates SR threshold on held-out test set
- Reports metrics on train/val/test splits
- Output: `results/split_metrics.csv`

---

## 🎯 Reproducing Specific Results

### **Table 1: Cross-Model SR Behavior**
```bash
python scripts/03_run_gpt2_experiments.py
python scripts/06_statistical_analysis.py
```
Results in: `results/statistical_tests.csv`

### **Table 2: Layer Ablation Study**
```bash
python scripts/04_layer_ablation.py
```
Results in: `results/layer_ablation_metrics.csv`

### **Table 3: SR vs Perplexity Baseline**
```bash
python scripts/05_baseline_comparison.py
```
Results in: `results/baseline_comparison_metrics.csv`

### **Figure 1: Main Results**
```bash
python scripts/07_generate_figures.py
```
Output: `../figures/publication_figure_main.png`

---

## ⏱️ Runtime Estimates

| Script | Runtime (CPU) | Output Size |
|--------|---------------|-------------|
| 01_generate_dataset.py | <1 min | 50 KB |
| 02_run_qwen_experiment.py | 15-20 min | 100 KB |
| 03_run_gpt2_experiments.py | 10-15 min | 200 KB |
| 04_layer_ablation.py | 15-20 min | 10 KB |
| 05_baseline_comparison.py | 2-3 min | 20 KB |
| 06_statistical_analysis.py | <1 min | 15 KB |
| 07_generate_figures.py | 1-2 min | 5 MB |
| 08_train_val_test_split.py | <1 min | 10 KB |
| **TOTAL** | **30-45 min** | **~6 MB** |

---

## 🐛 Troubleshooting

### **Issue: "ModuleNotFoundError: No module named 'transformer_lens'"**
```bash
pip install transformer-lens
```

### **Issue: "RuntimeError: CUDA out of memory"**
All scripts use CPU by default. No GPU required.

### **Issue: "FileNotFoundError: prompts_301.csv"**
Run `01_generate_dataset.py` first:
```bash
python scripts/01_generate_dataset.py
```

### **Issue: Scripts run slowly**
Expected on CPU. Qwen2.5-1.5B takes ~15-20 minutes for 301 prompts.

---

## 📧 Contact

For questions about reproducing results:
- Open an issue on GitHub
- Email: [your email after acceptance]

---

## 📄 License

MIT License - See LICENSE file in repository root

---

## ✅ Verification Checklist

After running all scripts, verify:

- [ ] `data/prompts_301.csv` exists (301 rows)
- [ ] `results/qwen_results_301.csv` exists (301 rows)
- [ ] `results/statistical_tests.csv` shows p=0.0052
- [ ] `../figures/publication_figure_main.png` exists
- [ ] Adversarial recall ≈ 95% in `results/qwen_results_301.csv`

---

**Ready to reproduce? Run `./setup.sh` then `./run_all_experiments.sh`!** 🚀

