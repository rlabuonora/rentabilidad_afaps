library(here)
library(janitor)
library(lubridate)

# Rentabilidad en ur
rentabilidad_ur_acumulacion <- here::here('data', 'rentareal.xls') %>%
  read_xls(sheet="Subfondo Acumulación", range="A9:G86") %>% 
  mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
  clean_names() %>% 
  select(-2) %>% 
  pivot_longer(-ano_mes, 
               names_to="administradora", 
               values_to="rentabilidad_ur") %>% 
  mutate(fondo="Acumulación")

rentabilidad_ur_retiro <- here::here('data', 'rentareal.xls') %>%
  read_xls(sheet="Subfondo Retiro", range="A9:G86") %>% 
  mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
  clean_names() %>% 
  select(-2) %>% 
  pivot_longer(-ano_mes, 
               names_to="administradora", 
               values_to="rentabilidad_ur") %>% 
  mutate(fondo="Retiro")

rentabilidad_ur_total <- here::here('data', 'rentareal.xls') %>%
  read_xls(sheet="Total", range="A9:K216") %>% 
  mutate(`AÑO MES`=ym(`AÑO MES`)) %>% 
  clean_names() %>% 
  select(-2) %>% 
  pivot_longer(-ano_mes, 
               names_to="administradora", 
               values_to="rentabilidad_ur") %>% 
  mutate(fondo="Total")

rentabilidad_real_ur <- bind_rows(rentabilidad_ur_total,
                                  rentabilidad_ur_retiro,
                                  rentabilidad_ur_acumulacion)

saveRDS(rentabilidad_real_ur, 
        file=here::here('data', 'rentabilidad_ur_bcu.rds'))
