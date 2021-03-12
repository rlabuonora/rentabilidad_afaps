library(readxl)
library(lubridate)
library(here)
library(janitor)

# Rentabilidad bruta nominal
rentabilidad_nominal_retiro_96_14 <- here::here('data', 'xls', 'rentnominal.xls') %>%
  read_xls(sheet="TOTAL", range="A9:K216") %>% 
  mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
  clean_names() %>% 
  select(-2) %>% 
  pivot_longer(-ano_mes, 
               names_to="administradora", 
               values_to="rentabilidad_nominal") %>% 
  mutate(fondo="Retiro")

rentabilidad_nominal_acumulacion_96_14 <- rentabilidad_nominal_retiro_96_14 %>% 
  mutate(fondo="Acumulación")

rentabilidad_nominal_retiro_14_20 <- here::here('data', 'xls', 'rentnominal.xls') %>%
  read_xls(sheet="Subfondo Retiro", range="A9:G86") %>% 
  mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
  clean_names() %>% 
  select(-2) %>% 
  pivot_longer(-ano_mes, 
               names_to="administradora", 
               values_to="rentabilidad_nominal") %>% 
  mutate(fondo="Retiro")

rentabilidad_nominal_acumulacion_14_20 <- here::here('data', 'xls', 'rentnominal.xls') %>%
  read_xls(sheet="Subfondo Acumulación", range="A9:G86") %>% 
  mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
  clean_names() %>% 
  select(-2) %>% 
  pivot_longer(-ano_mes, 
               names_to="administradora", 
               values_to="rentabilidad_nominal") %>% 
  mutate(fondo="Acumulación")


rentabilidad_nominal_bcu <- bind_rows(
  rentabilidad_nominal_retiro_96_14,
  rentabilidad_nominal_acumulacion_96_14,
  rentabilidad_nominal_retiro_14_20,
  rentabilidad_nominal_acumulacion_14_20) %>% 
  mutate(fuente="BCU")

saveRDS(rentabilidad_nominal_bcu, here::here('data', 'rds', 'rentabilidad_nominal_bcu.rds'))

# Rentabilidad Real
# rentabilidad_real_total <- here::here('data', 'rentareal.xls') %>%
#   read_xls(sheet="Total", range="A9:K216") %>% 
#   mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
#   clean_names() %>% 
#   select(-2) %>% 
#   relocate(ano_mes) %>% 
#   pivot_longer(-ano_mes, 
#                names_to="fondo", 
#                values_to="rentabilidad_real")
# 
# # Valor del fondo
# fap <- here::here('data', 'fap.xls') %>%
#   read_xls(sheet="FONDO DE AHORRO PREVISIONAL", range="A9:K304") %>% 
#   mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
#   clean_names() %>% 
#   select(-2) %>% 
#   pivot_longer(-ano_mes, 
#                names_to="fondo", 
#                values_to="valor_fondo")