library(readxl)
library(tidyverse)
library(lubridate)
library(janitor)

# 1. Valor Cuota fin de mes

# Fondo Total (1996-2014)
valor_cuota_fap <- here::here('data', 'valorcuotafindemes.xls') %>%
  read_xls(sheet="FONDO DE AHORRO PREVISIONAL", range="A9:I227") %>% 
  mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
  clean_names() %>% 
  pivot_longer(-ano_mes, 
               names_to="administradora", 
               values_to="valor_cuota") %>% 
  mutate(fondo="FAP")


# Fondo Acumulacion (2014-2020)
valor_cuota_acumulacion <- here::here('data', 'valorcuotafindemes.xls') %>%
  read_xls(sheet="SUBFONDO ACUMULACION", range="A9:E86") %>% 
  mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
  clean_names() %>% 
  pivot_longer(-ano_mes, 
               names_to="administradora", 
               values_to="valor_cuota") %>% 
  mutate(fondo="Acumulación")

# Fondo Retiro (2014-2020)
valor_cuota_retiro <- here::here('data', 'valorcuotafindemes.xls') %>%
  read_xls(sheet="SUBFONDO RETIRO", range="A9:E83") %>% 
  mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
  clean_names() %>% 
  pivot_longer(-ano_mes, 
               names_to="administradora", 
               values_to="valor_cuota") %>% 
  mutate(fondo="Retiro")

valor_cuota <- bind_rows(valor_cuota_fap, 
                         valor_cuota_retiro,
                         valor_cuota_acumulacion)


# 2. Valor Cuota promedio

# Fondo Total (1996-2014)
valor_cuota_fap <- here::here('data', 'valorcuotapromediomes.xls') %>%
  read_xls(sheet="FONDO DE AHORRO PREVISIONAL", range="A9:J227") %>% 
  mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
  clean_names() %>% 
  pivot_longer(-ano_mes, 
               names_to="administradora", 
               values_to="valor_cuota") %>% 
  mutate(fondo="FAP")


# Fondo Acumulacion (2014-2020)
valor_cuota_acumulacion <- here::here('data', 'valorcuotapromediomes.xls') %>%
  read_xls(sheet="SUBFONDO ACUMULACION", range="A9:F86") %>% 
  mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
  clean_names() %>% 
  pivot_longer(-ano_mes, 
               names_to="administradora", 
               values_to="valor_cuota") %>% 
  mutate(fondo="Acumulación")

# Fondo Retiro (2014-2020)
valor_cuota_retiro <- here::here('data', 'valorcuotapromediomes.xls') %>%
  read_xls(sheet="SUBFONDO RETIRO", range="A9:F86") %>% 
  mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
  clean_names() %>% 
  pivot_longer(-ano_mes, 
               names_to="administradora", 
               values_to="valor_cuota") %>% 
  mutate(fondo="Retiro")

valor_cuota_promedio <- bind_rows(valor_cuota_fap, 
                         valor_cuota_retiro,
                         valor_cuota_acumulacion)





saveRDS(valor_cuota_promedio, 
     file = here::here('data', 'valor_cuota_promediomes.rds'))
  