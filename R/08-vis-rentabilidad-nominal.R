library(tidyverse)
library(patchwork)
library(lubridate)

# Rentabilidad Nominal

rentabilidad_nominal_bcu <- readRDS(here::here("data", "rds", "rentabilidad_nominal_bcu.rds")) %>% 
  filter(administradora %in% c("afap_sura", "integracion",
                               "republica", "union_capital")) %>% 
  filter(fondo=="Acumulación") %>% 
  select(ano_mes, rentabilidad_nominal, administradora) %>% 
  mutate(fuente="BCU")

rentabilidad_nominal_cess <- readRDS(here::here("data", "rds", "rentabilidad_nominal_cess.rds")) %>% 
  filter(administradora %in% c("afap_sura", "integracion",
                               "republica", "union_capital")) %>% 
  filter(fondo=="Acumulación") %>% 
  select(ano_mes, rentabilidad_nominal_simple, 
         rentabilidad_nominal_indice, administradora) 
  
rentabilidad_nominal_cess <- pivot_longer(rentabilidad_nominal_cess, 
             cols=c(rentabilidad_nominal_simple, 
                    rentabilidad_nominal_indice),
             names_to="fuente",
             values_to="rentabilidad_nominal")
  

bind_rows(
  rentabilidad_nominal_bcu,
  rentabilidad_nominal_cess
) %>% 
  ggplot(aes(ano_mes, color=administradora)) + 
  geom_line(aes(y=rentabilidad_nominal)) +
  facet_wrap(~fuente, ncol=1)
  


ggsave(here::here('output', 'rentabilidad_nominal.png'))
