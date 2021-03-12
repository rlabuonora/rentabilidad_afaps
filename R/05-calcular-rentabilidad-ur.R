# rentabilidad bruta nominal -> rentabilidad bruta en ur

# La determinación de este guarismo se basa en la 
# rentabilidad nominal para el período de cálculo
# seleccionado multiplicada por
# la variación observada durante el mismo período para la Unidad
# Reajustable (variable impuesta por la normativa para este cálculo).

# Rentabilidad nominal capital en julio del 98 fue 31.6
rentabilidad_nominal_bcu %>% 
  filter(administradora=="capital") %>% 
  filter(year(ano_mes)==1998) %>% 
  filter(between(month(ano_mes), 6, 8))

# La UR fue 
ur %>% 
  filter(year(ano_mes)==1997) %>% 
  filter(between(month(ano_mes), 6, 8)) %>% 
  mutate(delta_ur = ur/lag(ur))

# 153.05 - Junio
# 157.62 - Julio
# 159.17 - Agosto

# valor cuota en urs




rentabilidad_nominal_bcu <- readRDS(here::here(
  "data", "rentabilidad_nominal_bcu.rds"
))


