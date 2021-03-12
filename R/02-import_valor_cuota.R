library(readxl)
library(tidyverse)
library(lubridate)
library(janitor)


# 2. Valor Cuota promedio

# Fondo Total (1996-2014)
valor_cuota_acumulacion_96_14 <- here::here('data', 'xls', 'valorcuotapromediomes.xls') %>%
  read_xls(sheet="FONDO DE AHORRO PREVISIONAL", range="A9:J227") %>% 
  mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
  clean_names() %>% 
  pivot_longer(-ano_mes, 
               names_to="administradora", 
               values_to="valor_cuota") %>% 
  mutate(fondo="Acumulación")

valor_cuota_retiro_96_14 <- here::here('data', 'xls', 'valorcuotapromediomes.xls') %>%
  read_xls(sheet="FONDO DE AHORRO PREVISIONAL", range="A9:J227") %>% 
  mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
  clean_names() %>% 
  pivot_longer(-ano_mes, 
               names_to="administradora", 
               values_to="valor_cuota") %>% 
  mutate(fondo="Retiro")


# Fondo Acumulacion (2014-2020)
valor_cuota_acumulacion_14_20 <- here::here('data', 'xls', 'valorcuotapromediomes.xls') %>%
  read_xls(sheet="SUBFONDO ACUMULACION", range="A9:F86") %>% 
  mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
  clean_names() %>% 
  pivot_longer(-ano_mes, 
               names_to="administradora", 
               values_to="valor_cuota") %>% 
  mutate(fondo="Acumulación")

# Fondo Retiro (2014-2020)
valor_cuota_retiro_14_20 <- here::here('data', 'xls', 'valorcuotapromediomes.xls') %>%
  read_xls(sheet="SUBFONDO RETIRO", range="A9:F86") %>% 
  mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
  clean_names() %>% 
  pivot_longer(-ano_mes, 
               names_to="administradora", 
               values_to="valor_cuota") %>% 
  mutate(fondo="Retiro")


# Juntar todo
valor_cuota_total <- bind_rows(
  valor_cuota_acumulacion_96_14,
  valor_cuota_retiro_96_14,
  valor_cuota_acumulacion_14_20,
  valor_cuota_retiro_14_20
)

saveRDS(valor_cuota_total,
        file = here::here("data", "rds", "valor_cuota_total.rds"))

  