#!/bin/bash

# Setup script for Safety Ratio Research reproduction
# SPCOM 2026 Paper

set -e  # Exit on error

echo "=========================================="
echo "Safety Ratio Research - Setup"
echo "=========================================="
echo ""

# Check Python version
echo "Checking Python version..."
python_version=$(python3 --version 2>&1 | awk '{print $2}')
echo "✅ Python version: $python_version"
echo ""

# Check if virtual environment exists
VENV_PATH="/Users/amac/MechInterpLab/venv"
if [ ! -d "$VENV_PATH" ]; then
    echo "Creating virtual environment..."
    python3 -m venv "$VENV_PATH"
    echo "✅ Virtual environment created"
else
    echo "✅ Virtual environment already exists"
fi
echo ""

# Activate virtual environment
echo "Activating virtual environment..."
source "$VENV_PATH/bin/activate"
echo "✅ Virtual environment activated"
echo ""

# Upgrade pip
echo "Upgrading pip..."
pip install --upgrade pip --quiet
echo "✅ pip upgraded"
echo ""

# Install dependencies
echo "Installing dependencies from requirements.txt..."
echo "(This may take 2-3 minutes...)"
pip install -r requirements.txt --quiet
echo "✅ Dependencies installed"
echo ""

# Create necessary directories
echo "Creating directory structure..."
mkdir -p data
mkdir -p results
mkdir -p ../figures
echo "✅ Directories created"
echo ""

# Verify installation
echo "Verifying installation..."
python3 -c "import torch; print(f'  PyTorch: {torch.__version__}')"
python3 -c "import transformer_lens; print(f'  TransformerLens: {transformer_lens.__version__}')"
python3 -c "import pandas; print(f'  Pandas: {pandas.__version__}')"
python3 -c "import numpy; print(f'  NumPy: {numpy.__version__}')"
python3 -c "import scipy; print(f'  SciPy: {scipy.__version__}')"
python3 -c "import matplotlib; print(f'  Matplotlib: {matplotlib.__version__}')"
echo "✅ All packages verified"
echo ""

echo "=========================================="
echo "✅ Setup Complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "  1. Run all experiments:"
echo "     ./run_all_experiments.sh"
echo ""
echo "  2. Or run individual scripts:"
echo "     python scripts/01_generate_dataset.py"
echo "     python scripts/02_run_qwen_experiment.py"
echo "     ..."
echo ""
echo "=========================================="

