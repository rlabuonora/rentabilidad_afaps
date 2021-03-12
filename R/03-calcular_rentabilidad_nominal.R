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


# CESS: 1996-2014
rentabilidad_nominal_cess <- valor_cuota_total %>% 
  group_by(administradora, fondo) %>% 
  mutate(rentabilidad_nominal= 100 * (valor_cuota/lag(valor_cuota, 12) - 1)) %>% 
  ungroup() %>% 
  mutate(fuente="cess")


saveRDS(rentabilidad_nominal_cess, 
        file = here::here("data", "rds", "rentabilidad_nominal_cess.rds"))


# CESS 2014-2020

# Armar el valor cuota con fondos Retiro y Acumulación duplicados
# para antes de 2014
# Tomar datos 96-2013




# Todos tienen 2
valor_cuota_total %>% 
  count(ano_mes, fondo, administradora) %>% 
  count(n)

rentabilidad_nominal_cess_14_20 <- valor_cuota_total %>% 
  group_by(administradora, fondo) %>% 
  mutate(rentabilidad_nominal= 100 * (((valor_cuota/lag(valor_cuota, 36))^(1/3)) - 1)) %>% 
  arrange(administradora, fondo, ano_mes) %>% 
  filter(ano_mes >= as.Date("2014-08-01")) %>% 
  mutate(fuente="cess") %>% 
  ungroup()

saveRDS(rentabilidad_nominal_cess_14_20, 
        file = here::here("data", "rentabilidad_nominal_cess_14_20.rds"))

