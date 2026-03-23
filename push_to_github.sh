#!/bin/bash

# Script to create GitHub repo and push SPCOM 2026 paper
# This script will guide you through the process

set -e  # Exit on error

echo "=========================================="
echo "GitHub Repository Setup for SPCOM 2026"
echo "=========================================="
echo ""

# Configuration
REPO_NAME="safety-ratio-spcom2026"
REPO_DESCRIPTION="Safety Ratio: Quantifying Grounding vs Confidence Decoupling in Transformers (SPCOM 2026 Submission)"

echo "Repository name: $REPO_NAME"
echo "Description: $REPO_DESCRIPTION"
echo ""

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed."
    echo ""
    echo "Please install it first:"
    echo "  brew install gh"
    echo ""
    echo "Then run this script again."
    exit 1
fi

# Check if user is authenticated
echo "Checking GitHub authentication..."
if ! gh auth status &> /dev/null; then
    echo "❌ Not authenticated with GitHub."
    echo ""
    echo "Please authenticate first:"
    echo "  gh auth login"
    echo ""
    echo "Then run this script again."
    exit 1
fi

echo "✅ GitHub CLI authenticated"
echo ""

# Initialize git repo if not already initialized
if [ ! -d .git ]; then
    echo "Initializing git repository..."
    git init
    echo "✅ Git repository initialized"
else
    echo "✅ Git repository already exists"
fi

# Create .gitignore
echo "Creating .gitignore..."
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
EOF

echo "✅ .gitignore created"
echo ""

# Add files
echo "Adding files to git..."
git add .
echo "✅ Files added"
echo ""

# Commit
echo "Creating initial commit..."
git commit -m "Initial commit: SPCOM 2026 submission-ready paper

- 5-page IEEE format paper
- Double-blind review compliant
- Safety Ratio: Grounding vs Confidence Decoupling
- Includes all tables, figures, and statistical results
- Compliance checklist and page reduction summary included"

echo "✅ Initial commit created"
echo ""

# Create GitHub repo
echo "Creating GitHub repository: $REPO_NAME"
echo ""
gh repo create "$REPO_NAME" \
    --private \
    --description "$REPO_DESCRIPTION" \
    --source=. \
    --remote=origin \
    --push

echo ""
echo "=========================================="
echo "✅ SUCCESS!"
echo "=========================================="
echo ""
echo "Your paper has been pushed to GitHub!"
echo ""
echo "Repository URL:"
gh repo view --web --json url -q .url
echo ""
echo "To view in browser:"
echo "  gh repo view --web"
echo ""
echo "To make the repo public later (after submission):"
echo "  gh repo edit --visibility public"
echo ""
echo "=========================================="

