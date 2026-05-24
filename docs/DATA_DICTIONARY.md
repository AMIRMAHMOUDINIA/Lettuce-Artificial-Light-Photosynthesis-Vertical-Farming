# Data Dictionary

File: `data/utphotolab_lettuce_LED.csv`

| Column | Meaning | Unit / scale |
|---|---|---|
| `treatment` | LED treatment code | R, RB12, RB8, RB4, RB1, B |
| `blue_pct` | Blue-light fraction in the LED spectrum | % |
| `Pn` | Net photosynthetic rate | µmol CO2 m-2 s-1 |
| `Pn_se` | Standard error of net photosynthesis | same as `Pn` |
| `Amax` | Maximum photosynthetic capacity or fitted maximum photosynthesis value | µmol CO2 m-2 s-1 |
| `Amax_se` | Standard error of Amax | same as `Amax` |
| `Fv_Fm` | Maximum quantum yield of photosystem II | dimensionless |
| `FvFm_se` | Standard error of Fv/Fm | dimensionless |
| `PhiII` | Operating efficiency of photosystem II | dimensionless |
| `PhiII_se` | Standard error of PhiII | dimensionless |
| `stomatal_conductance` | Stomatal conductance | confirm exact unit before public release |
| `sc_se` | Standard error of stomatal conductance | same as `stomatal_conductance` |
| `dry_weight_g` | Shoot dry weight | g |
| `dw_se` | Standard error of dry weight | g |
