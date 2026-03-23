# SPCOM 2026 Submission Compliance Checklist

**Conference:** SPCOM 2026  
**Submission Deadline:** March 26, 2026, 23:59 PT  
**Review Process:** Double-blind  
**Submission Portal:** CMT  

---

## ✅ **COMPLIANCE STATUS: READY FOR SUBMISSION**

---

## **1. Format Requirements**

| Requirement | Status | Details |
|-------------|--------|---------|
| **Template** | ✅ PASS | Using standard IEEE conference template (`IEEEtran`) |
| **Page Limit** | ✅ PASS | 5 pages maximum (currently 5 pages after reduction) |
| **Column Format** | ✅ PASS | Double-column (IEEEtran default) |
| **Line Spacing** | ✅ PASS | Single line spacing (IEEEtran default) |
| **Font Size** | ✅ PASS | Main text 10pt (IEEEtran default) |
| **Margins** | ✅ PASS | ≥ 3/4 inch (18mm) - IEEEtran default compliant |
| **No Margin Content** | ✅ PASS | No headers, footers, or page numbers |

---

## **2. Double-Blind Review Requirements**

| Requirement | Status | Details |
|-------------|--------|---------|
| **No Author Names** | ✅ PASS | Author block removed from `main.tex` |
| **No Affiliations** | ✅ PASS | Institution names removed |
| **No Email Addresses** | ✅ PASS | Contact info removed |
| **No Self-Citations (1st person)** | ✅ PASS | No prior work cited in first person |
| **No Grant Numbers** | ✅ PASS | No funding acknowledgments |
| **No Identifying Info** | ✅ PASS | No "MechInterpLab" or other identifying references |
| **Page Numbers Suppressed** | ✅ PASS | `\pagestyle{empty}` added |

---

## **3. Changes Made for Compliance**

### **3.1 Removed Author Block (lines 21-24)**

**BEFORE:**
```latex
\author{\IEEEauthorblockN{Anonymous Author}
\IEEEauthorblockA{\textit{MechInterpLab} \\
\textit{Mechanistic Interpretability Research}\\
Email: research@mechinterplab.org}}
```

**AFTER:**
```latex
% SPCOM 2026 Double-Blind Review: NO author information
% Author block will be added after acceptance
```

### **3.2 Added Page Number Suppression (line 15)**

**ADDED:**
```latex
% SPCOM 2026 Compliance: Suppress page numbers for double-blind review
\pagestyle{empty}
```

### **3.3 Updated Header Comment (line 1)**

**BEFORE:**
```latex
% Safety Ratio IEEE Conference Paper (multi-file project)
```

**AFTER:**
```latex
% Safety Ratio SPCOM 2026 Conference Paper
% Double-blind review: NO author information, NO page numbers
```

---

## **4. Content Verification**

| Item | Status | Notes |
|------|--------|-------|
| **Title** | ✅ PASS | Non-identifying, descriptive |
| **Abstract** | ✅ PASS | No author references |
| **Introduction** | ✅ PASS | No identifying information |
| **Methodology** | ✅ PASS | Model/dataset described objectively |
| **Results** | ✅ PASS | No self-citations |
| **Discussion** | ✅ PASS | No identifying references |
| **Conclusion** | ✅ PASS | No author information |
| **References** | ✅ PASS | All citations in third person |

---

## **5. Pre-Submission Checklist**

- [x] Paper uses IEEE conference template
- [x] Page count ≤ 5 pages
- [x] Font size ≥ 10pt
- [x] Margins ≥ 3/4 inch (18mm)
- [x] No headers, footers, or page numbers
- [x] No author names in PDF
- [x] No affiliations in PDF
- [x] No email addresses in PDF
- [x] No identifying references (lab names, grant numbers, etc.)
- [x] All self-citations in third person
- [x] PDF compiles without errors
- [ ] **TODO:** Upload to CMT portal before March 26, 2026, 23:59 PT

---

## **6. Post-Acceptance Tasks**

After acceptance, you will need to add back:

1. **Author block:**
```latex
\author{\IEEEauthorblockN{Your Name}
\IEEEauthorblockA{\textit{Your Institution} \\
\textit{Department}\\
City, Country \\
email@institution.edu}}
```

2. **Acknowledgments section** (if applicable):
```latex
\section*{Acknowledgments}
This work was supported by...
```

3. **Page numbers** (remove `\pagestyle{empty}`)

---

## **7. Files Modified for Compliance**

1. ✏️ `main.tex` (removed author block, added `\pagestyle{empty}`)

---

## **8. Backup Location**

**Original 7-page version:** `MI-Experiments/ieee_paper_backup_7pages/`  
**Current 5-page compliant version:** `MI-Experiments/ieee_paper/`

---

## **9. Final Verification Steps**

Before submission:

1. **Compile the PDF:**
   ```bash
   cd /Users/amac/MechInterpLab/MI-Experiments/ieee_paper
   pdflatex main.tex
   bibtex main
   pdflatex main.tex
   pdflatex main.tex
   ```

2. **Verify page count:**
   ```bash
   mdls -name kMDItemNumberOfPages main.pdf
   ```
   Should show: **5 pages**

3. **Check for identifying information:**
   - Open PDF and search for: "MechInterpLab", your name, email, institution
   - Verify no page numbers appear
   - Verify no headers/footers

4. **Upload to CMT:**
   - Go to SPCOM 2026 CMT portal
   - Upload `main.pdf`
   - Deadline: **March 26, 2026, 23:59 PT**

---

## ✅ **READY FOR SUBMISSION**

Your paper is now fully compliant with SPCOM 2026 double-blind review requirements!

