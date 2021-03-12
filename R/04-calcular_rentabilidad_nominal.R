library(scales)

# valor cuota -> rentabilidad nominal

# La rentabilidad bruta nominal para un período se determina como 
# el cociente entre el valor cuota promedio del período y 
# el valor cuota promedio del período anterior. 
# Este dato se determina para diferentes períodos: 
# mensual, anual y para los últimos cinco años de vigencia del sistema.
# Estos guarismos se toman como 
# insumo para el cálculo de las rentabilidades reales. 

valor_cuota_total <- readRDS(here::here('data', 'rds', 'valor_cuota_total.rds'))

rentabilidad_nominal_cess <- valor_cuota_total %>% 
  group_by(administradora, fondo) %>% 
  mutate(rentabilidad_nominal_simple= 100 * (valor_cuota/lag(valor_cuota, 12) - 1)) %>%
  mutate(rentabilidad_nominal_indice = 100 * 
           (((valor_cuota/lag(valor_cuota, 36))^(1/3)) - 1)) %>%
  ungroup() %>% 
  mutate(fuente="cess")


saveRDS(rentabilidad_nominal_cess, 
        file = here::here("data", "rds", "rentabilidad_nominal_cess.rds"))


