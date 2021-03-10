library(readxl)
library(tidyverse)
library(lubridate)
library(janitor)


# Rentabilidad Real

rentabilidad_real_acumulacion <- here::here('data', 'rentareal.xls') %>%
  read_xls(sheet="Subfondo Acumulación", range="A9:G86") %>% 
  mutate(fondo="Acumulación")

rentabilidad_real_retiro <- here::here('data', 'rentareal.xls') %>%
  read_xls(sheet="Subfondo Retiro", range="A9:G86") %>% 
  mutate(fondo="Retiro")

rentabilidad_real_total <- here::here('data', 'rentareal.xls') %>%
  read_xls(sheet="Total", range="A9:K216") %>% 
  mutate(fondo="Total",
         `AÑO MES`=ym(`AÑO MES`)) %>% 
  clean_names() %>% 
  select(-2) %>% 
  relocate(ano_mes, fondo) 


# Valor Cuota
valor_cuota <- here::here('data', 'valorcuotapromediomes.xls') %>%
  read_xls(sheet="FONDO DE AHORRO PREVISIONAL", range="A9:J227") %>% 
  mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
  clean_names()

# Rentabilidad bruta nominal
rentabilidad_nominal <- here::here('data', 'rentnominal.xls') %>%
  read_xls(sheet="TOTAL", range="A9:J216") %>% 
  mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
  clean_names() %>% 
  select(-2)

# Valor del fondo
fap <- here::here('data', 'fap.xls') %>%
  read_xls(sheet="FONDO DE AHORRO PREVISIONAL", range="A9:K304") %>% 
  mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
  clean_names() %>% 
  select(-2)
  