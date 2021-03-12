library(here)
library(janitor)
library(lubridate)
library(tidyverse)

# Rentabilidad en ur
rentabilidad_ur_acumulacion_14_20 <- here::here('data', 'xls', 'rentareal.xls') %>%
  read_xls(sheet="Subfondo Acumulación", range="A9:G86") %>% 
  mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
  clean_names() %>% 
  select(-2) %>% 
  pivot_longer(-ano_mes, 
               names_to="administradora", 
               values_to="rentabilidad_ur") %>% 
  mutate(fondo="Acumulación")

rentabilidad_ur_retiro_14_20 <- rentabilidad_ur_acumulacion_14_20 %>% 
  mutate(fondo="Acumulación")



rentabilidad_ur_retiro_14_20 <- here::here('data', 'xls', 'rentareal.xls') %>%
  read_xls(sheet="Subfondo Retiro", range="A9:G86") %>% 
  mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
  clean_names() %>% 
  select(-2) %>% 
  pivot_longer(-ano_mes, 
               names_to="administradora", 
               values_to="rentabilidad_ur") %>% 
  mutate(fondo="Retiro")

rentabilidad_ur_acumulacion_96_14 <- here::here('data', 'xls', 'rentareal.xls') %>%
  read_xls(sheet="Total", range="A9:K216") %>% 
  mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
  clean_names() %>% 
  select(-2) %>% 
  pivot_longer(-ano_mes, 
               names_to="administradora", 
               values_to="rentabilidad_ur") %>% 
  mutate(fondo="Acumulación")

rentabilidad_ur_retiro_96_14 <- here::here('data', 'xls', 'rentareal.xls') %>%
  read_xls(sheet="Total", range="A9:K216") %>% 
  mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
  clean_names() %>% 
  select(-2) %>% 
  pivot_longer(-ano_mes, 
               names_to="administradora", 
               values_to="rentabilidad_ur") %>% 
  mutate(fondo="Retiro")

rentabilidad_real_ur <- bind_rows(rentabilidad_ur_acumulacion_96_14,
                                  rentabilidad_ur_retiro_96_14,
                                  rentabilidad_ur_acumulacion_14_20,
                                  rentabilidad_ur_retiro_14_20) %>% 
  mutate(fuente="BCU")

saveRDS(rentabilidad_real_ur, 
        file=here::here('data', 'rds', 'rentabilidad_ur_bcu.rds'))
