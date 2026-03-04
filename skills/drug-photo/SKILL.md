# Drug Photo Skill

## Overview

Snap a photo of a medication, get personalised pharmacogenomic dosage guidance in seconds.

This skill reuses `pharmgx-reporter/pharmgx_reporter.py` with the `--drug` single-drug lookup mode. No separate Python script — the same validated 51-drug CPIC pipeline powers both the full report and the photo lookup.

## How It Works

1. **Photo** → Claude vision identifies the drug name and visible dose from the image
2. **Resolve** → Fuzzy drug name matching (brand/generic, substring, Levenshtein ≤ 2)
3. **Genotype** → Reads real 23andMe data (gzip-compressed `.txt.gz` supported)
4. **Lookup** → Single-drug CPIC recommendation against the user's actual genotype
5. **Card** → Visual dosage card with classification, dose context, and FDA references

## Supported Drugs (51)

All drugs from the CPIC guideline set across 12 genes:

| Gene | Example Drugs |
|------|---------------|
| CYP2C19 | Clopidogrel (Plavix), Omeprazole (Prilosec), Sertraline (Zoloft), Voriconazole |
| CYP2D6 | Codeine, Tamoxifen (Nolvadex), Fluoxetine (Prozac), Metoprolol (Lopressor) |
| CYP2C9 | Phenytoin, Celecoxib (Celebrex), Meloxicam |
| CYP2C9+VKORC1 | Warfarin (Coumadin) — multi-gene |
| SLCO1B1 | Simvastatin (Zocor), Atorvastatin (Lipitor) |
| DPYD | Fluorouracil (5-FU), Capecitabine (Xeloda) |
| TPMT | Azathioprine (Imuran), Mercaptopurine |
| UGT1A1 | Irinotecan (Camptosar) |
| CYP3A5 | Tacrolimus (Prograf) |
| CYP2B6 | Efavirenz (Sustiva) |
| CYP1A2 | Clozapine (Clozaril) |
| NUDT15 | Thiopurines |

## Classification Labels

| Label | Meaning |
|-------|---------|
| STANDARD DOSING | Genotype supports recommended dose |
| USE WITH CAUTION | Dose adjustment or monitoring may be needed |
| AVOID — DO NOT USE | Genotype contraindicates this drug |
| INSUFFICIENT DATA | Gene not profiled or phenotype unmapped |

## CLI Usage

```bash
# Single drug lookup against real 23andMe data
python pharmgx_reporter.py --input patient.txt.gz --drug Plavix
python pharmgx_reporter.py --input patient.txt.gz --drug codeine --dose 30mg

# Via clawbio.py (uses Manuel's real data in --demo mode)
python clawbio.py run drugphoto --demo --drug Plavix
python clawbio.py run drugphoto --demo --drug sertraline --dose 50mg
```

## Telegram Integration

Send a drug photo to RoboTerri. Claude vision identifies the drug and calls:
```
clawbio(skill="drugphoto", mode="demo", drug_name="Plavix", visible_dose="75mg")
```

## Data Sources

- **CPIC Guidelines**: Clinical Pharmacogenetics Implementation Consortium (cpicpgx.org)
- **FDA Table of Pharmacogenomic Biomarkers in Drug Labeling**
- **31-SNP PGx panel** across 12 genes (DTC-compatible)
- **Real 23andMe genotype data** in demo mode (21/25 PGx SNPs covered)

## Future Expansion

- HLA typing for allergy-related pharmacogenomics (carbamazepine/HLA-B*1502, abacavir/HLA-B*5701)
- Additional drugs from PharmGKB level 1A/1B evidence
- Multi-language dosage cards

## Disclaimer

ClawBio is a research and educational tool. It is not a medical device and does not provide clinical diagnoses. Consult a healthcare professional before making any medical decisions.
