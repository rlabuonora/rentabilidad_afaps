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


# CESS: 1996-2014
rentabilidad_nominal_cess_96_14 <- valor_cuota %>% 
  group_by(administradora) %>% 
  mutate(rentabilidad_nominal= 100 * (valor_cuota/lag(valor_cuota, 12) - 1)) %>% 
  filter(ano_mes > as.Date("1997-06-01")) %>% 
  filter(ano_mes < as.Date("2014-01-01")) %>% 
  ungroup() %>% 
  mutate(fuente="cess")


saveRDS(rentabilidad_nominal_cess_96_14, 
        file = here::here("data", "rentabilidad_nominal_cess_96_14.rds"))


# CESS 2014-2020

# Armar el valor cuota con fondos Retiro y Acumulación duplicados
# para antes de 2014
# Tomar datos 96-2013
valor_cuota_fap <- valor_cuota %>% 
  filter(fondo=="FAP")

# Duplicarlos con los dos fondos
valor_cuota_fap_retiro <- valor_cuota_fap %>% 
  mutate(fondo="Retiro")

valor_cuota_fap_acumulacion <- valor_cuota_fap %>% 
  mutate(fondo="Acumulación")

# Juntar todo
valor_cuota_total <- bind_rows(
  valor_cuota_fap_retiro,
  valor_cuota_fap_acumulacion,
  filter(valor_cuota, fondo %in% c("Retiro", "Acumulación"))
)

saveRDS(valor_cuota_total, 
        file = here::here("data", "valor_cuota_total.rds"))



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

