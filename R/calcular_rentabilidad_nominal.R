library(scales)

# valor cuota -> rentabilidad nominal

# La rentabilidad bruta nominal para un período se determina como 
# el cociente entre el valor cuota promedio del período y 
# el valor cuota promedio del período anterior. 
# Este dato se determina para diferentes períodos: 
# mensual, anual y para los últimos cinco años de vigencia del sistema.
# Estos guarismos se toman como 
# insumo para el cálculo de las rentabilidades reales. 

valor_cuota <- readRDS(here::here('data', 'valor_cuota_promediomes.rds'))


# CESS
rentabilidad_nominal_cess <- valor_cuota %>% 
  group_by(administradora) %>% 
  mutate(rentabilidad_nominal= 100 * (valor_cuota/lag(valor_cuota, 12) - 1)) %>% 
  filter(ano_mes > as.Date("1997-06-01")) %>% 
  ungroup() %>% 
  mutate(fuente="cess")


saveRDS(rentabilidad_nominal_cess, 
        file = here::here("data", "rentabilidad_nominal_cess.rds"))


