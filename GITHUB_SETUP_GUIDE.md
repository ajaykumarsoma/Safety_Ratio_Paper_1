# GitHub Repository Setup Guide

This guide provides **two methods** to push your SPCOM 2026 paper to GitHub.

---

## 🚀 **METHOD 1: Automated Script (Recommended)**

### **Prerequisites**

1. **Install GitHub CLI** (if not already installed):
   ```bash
   brew install gh
   ```

2. **Authenticate with GitHub**:
   ```bash
   gh auth login
   ```
   - Choose "GitHub.com"
   - Choose "HTTPS"
   - Authenticate via browser

### **Run the Script**

```bash
cd /Users/amac/MechInterpLab/MI-Experiments/ieee_paper
./push_to_github.sh
```

This will:
- ✅ Initialize git repository
- ✅ Create `.gitignore` for LaTeX files
- ✅ Create initial commit
- ✅ Create private GitHub repo: `safety-ratio-spcom2026`
- ✅ Push all files to GitHub
- ✅ Display repository URL

**Done!** Your paper is now on GitHub.

---

## 📝 **METHOD 2: Manual Setup**

### **Step 1: Install GitHub CLI** (if needed)

```bash
brew install gh
gh auth login
```

### **Step 2: Initialize Git Repository**

```bash
cd /Users/amac/MechInterpLab/MI-Experiments/ieee_paper

# Initialize git
git init

# Create .gitignore
cat > .gitignore << 'EOF'
*.aux
*.log
*.out
*.bbl
*.blg
*.synctex.gz
.DS_Store
EOF
```

### **Step 3: Add and Commit Files**

```bash
# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: SPCOM 2026 submission-ready paper"
```

### **Step 4: Create GitHub Repository**

```bash
# Create private repo and push
gh repo create safety-ratio-spcom2026 \
    --private \
    --description "Safety Ratio: Grounding vs Confidence Decoupling (SPCOM 2026)" \
    --source=. \
    --remote=origin \
    --push
```

### **Step 5: View Repository**

```bash
# Open in browser
gh repo view --web
```

---

## 🌐 **METHOD 3: Via GitHub Website** (No CLI)

### **Step 1: Create Repository on GitHub.com**

1. Go to https://github.com/new
2. Repository name: `safety-ratio-spcom2026`
3. Description: "Safety Ratio: Grounding vs Confidence Decoupling (SPCOM 2026)"
4. Choose **Private**
5. Click "Create repository"

### **Step 2: Initialize and Push from Terminal**

```bash
cd /Users/amac/MechInterpLab/MI-Experiments/ieee_paper

# Initialize git
git init

# Create .gitignore
echo "*.aux" > .gitignore
echo "*.log" >> .gitignore
echo "*.out" >> .gitignore
echo ".DS_Store" >> .gitignore

# Add files
git add .

# Commit
git commit -m "Initial commit: SPCOM 2026 submission"

# Add remote (replace YOUR_USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/safety-ratio-spcom2026.git

# Push
git branch -M main
git push -u origin main
```

---

## 📂 **What Will Be Uploaded**

Your repository will contain:

```
safety-ratio-spcom2026/
├── main.tex                              # Main LaTeX file
├── build.sh                              # Build script
├── sections/
│   ├── abstract.tex
│   ├── introduction.tex
│   ├── background.tex
│   ├── methodology.tex
│   ├── results.tex
│   ├── discussion.tex
│   ├── conclusion.tex
│   └── references.tex
├── figures/
│   ├── publication_figure_main.png
│   ├── three_pillars_analysis_300prompts.png
│   ├── multi_model_comparison.png
│   └── baseline_comparison.png
├── SPCOM2026_COMPLIANCE_CHECKLIST.md     # Compliance verification
├── PAGE_REDUCTION_SUMMARY.md             # Page reduction details
├── GITHUB_SETUP_GUIDE.md                 # This file
└── push_to_github.sh                     # Automated setup script
```

---

## 🔒 **Privacy Settings**

The repository is created as **PRIVATE** by default to protect your submission during the review process.

**After acceptance**, you can make it public:

```bash
gh repo edit --visibility public
```

Or via GitHub website:
1. Go to repository Settings
2. Scroll to "Danger Zone"
3. Click "Change visibility" → "Make public"

---

## 🔄 **Future Updates**

To push updates after making changes:

```bash
cd /Users/amac/MechInterpLab/MI-Experiments/ieee_paper

# Add changes
git add .

# Commit with message
git commit -m "Update: [describe your changes]"

# Push
git push
```

---

## ✅ **Verification**

After pushing, verify your repository:

```bash
# View in browser
gh repo view --web

# Or check status
git status
git log --oneline
```

---

## 🆘 **Troubleshooting**

### **Issue: "gh: command not found"**
```bash
brew install gh
```

### **Issue: "Authentication required"**
```bash
gh auth login
```

### **Issue: "Permission denied"**
- Make sure you're authenticated: `gh auth status`
- Try re-authenticating: `gh auth login`

### **Issue: "Repository already exists"**
- Choose a different name, or
- Delete the existing repo first: `gh repo delete YOUR_USERNAME/safety-ratio-spcom2026`

---

## 📧 **Need Help?**

If you encounter issues, you can:
1. Check GitHub CLI docs: https://cli.github.com/manual/
2. Check git status: `git status`
3. View git log: `git log`

---

**Ready to push? Run the automated script:**

```bash
./push_to_github.sh
```

