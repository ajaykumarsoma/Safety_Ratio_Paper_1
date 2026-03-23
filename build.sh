#!/usr/bin/env bash
set -e

# Simple build script for the Safety Ratio IEEE paper (two-column conference format)
# Usage: from the MI-Experiments/ieee_paper directory run:
#   chmod +x build.sh
#   ./build.sh

pdflatex -interaction=nonstopmode main.tex
bibtex main || true  # not strictly needed because we use thebibliography
pdflatex -interaction=nonstopmode main.tex
pdflatex -interaction=nonstopmode main.tex

