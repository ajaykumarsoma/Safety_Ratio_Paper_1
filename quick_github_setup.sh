#!/bin/bash

# Quick GitHub setup without requiring gh CLI
# This prepares the repo locally and gives you instructions

set -e

echo "=========================================="
echo "GitHub Repository Setup (Quick Method)"
echo "=========================================="
echo ""

# Initialize git repo if not already initialized
if [ ! -d .git ]; then
    echo "📦 Initializing git repository..."
    git init
    echo "✅ Git repository initialized"
    echo ""
else
    echo "✅ Git repository already exists"
    echo ""
fi

# Create .gitignore
echo "📝 Creating .gitignore..."
cat > .gitignore << 'EOF'
# LaTeX auxiliary files
*.aux
*.log
*.out
*.toc
*.bbl
*.blg
*.synctex.gz
*.fdb_latexmk
*.fls
*.nav
*.snm
*.vrb

# macOS
.DS_Store

# Backup files
*~
*.bak

# Build directory
build/

# PDF output (optional - uncomment if you don't want to track PDFs)
# *.pdf
EOF

echo "✅ .gitignore created"
echo ""

# Add files
echo "📂 Adding files to git..."
git add .
echo "✅ Files staged for commit"
echo ""

# Commit
echo "💾 Creating initial commit..."
git commit -m "Initial commit: SPCOM 2026 submission-ready paper

- 5-page IEEE format paper
- Double-blind review compliant
- Safety Ratio: Grounding vs Confidence Decoupling
- Includes all tables, figures, and statistical results
- Compliance checklist and documentation included" || echo "⚠️  No changes to commit (already committed)"

echo ""
echo "=========================================="
echo "✅ Local Git Repository Ready!"
echo "=========================================="
echo ""
echo "📋 NEXT STEPS:"
echo ""
echo "1️⃣  Go to GitHub and create a new repository:"
echo "   👉 https://github.com/new"
echo ""
echo "2️⃣  Repository settings:"
echo "   • Name: safety-ratio-spcom2026"
echo "   • Description: Safety Ratio: Grounding vs Confidence Decoupling (SPCOM 2026)"
echo "   • Visibility: Private (for double-blind review)"
echo "   • DO NOT initialize with README, .gitignore, or license"
echo ""
echo "3️⃣  After creating the repo, run these commands:"
echo ""
echo "   git branch -M main"
echo "   git remote add origin https://github.com/YOUR_USERNAME/safety-ratio-spcom2026.git"
echo "   git push -u origin main"
echo ""
echo "   (Replace YOUR_USERNAME with your actual GitHub username)"
echo ""
echo "=========================================="
echo ""
echo "💡 TIP: If you have GitHub CLI installed, you can use:"
echo "   ./push_to_github.sh"
echo ""
echo "   To install GitHub CLI:"
echo "   brew install gh"
echo ""
echo "=========================================="

