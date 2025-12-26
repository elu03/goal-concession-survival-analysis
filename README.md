# goal-concession-survival-analysis
Survival analysis of goal concession in FIFA Club World Cup 2025
# Statistical Analysis of Goal Concession in FIFA Club World Cup 2025

## Author
**Elu, Odibe Olawale** 
📧 Email: eluolawale@gmail.com

## Overview
This project applies **survival analysis techniques** to study the timing and determinants of goal concession in matches from the **FIFA Club World Cup 2025**.

The study models the time to goal concession using:
- Kaplan–Meier survival estimation
- Cox Proportional Hazards regression

## Objectives
- Estimate the average survival time before conceding a goal
- Identify key risk factors influencing early goal concession
- Provide insights for coaches and football analysts

## Methodology
- **Data source:** FIFA Club World Cup 2025 match records
- **Sample size:** 126 match observations
- **Key variables:** 
  Opponent strength, possession, errors leading to shots, red cards, GK saves, corner kicks, and interceptions

## Statistical Techniques
- Kaplan–Meier survival curves
- Cox Proportional Hazards Model
- Proportional hazard assumption tests

## Key Findings
- Goal concession risk increases significantly after the 60th minute
- Opponent strength, defensive errors, red cards, and opponent big chances significantly affect goal concession timing
- Goalkeeper saves reduce the hazard of conceding

## Files
- `CWC.docx` – Full research paper
- `CWC.R` – Survival analysis scripts (R)
- `CWC.xlsx` - dataset
- `CWC.docx` – Visualizations and tables

## Tools Used
- R
- Survival Analysis (`survival`, `survminer`)
- Descriptive and inferential statistics

## License
This project is released for academic and research use.
