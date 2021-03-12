library(tidyverse)
library(patchwork)


rentabilidades <- readRDS(here::here("data", "rentabilidades.rds")) %>% 
  filter(administradora %in% c("afap_sura", "integracion",
                               "republica", "union_capital")) %>% 
  mutate(fuente="CESS")

# rentabilidad en ur simple
rentabilidades %>% 
  filter(fondo=="Acumulación") %>% 
  ggplot(aes(ano_mes, rentabilidad_ur_simple, color=administradora)) +
  geom_line()

# rentabilidad en ur cagr
rentabilidad_cess_ur_plot <- rentabilidades %>% 
  filter(fondo=="Acumulación") %>% 
  ggplot(aes(ano_mes, rentabilidad_ur_cagr, color=administradora)) +
  geom_line()


# Rentabilidad en ui simples
rentabilidades %>% 
  filter(fondo=="Acumulación") %>% 
  ggplot(aes(ano_mes, rentabilidad_ui_simple, color=administradora)) +
  geom_line()

# Rentabilidad en ui cagr
rentabilidades %>% 
  filter(fondo=="Acumulación",) %>% 
  ggplot(aes(ano_mes, rentabilidad_ui_cagr, color=administradora)) +
  geom_line()

# Ver datos BCU
rentabilidad_real_bcu_ur <- readRDS(file=here::here('data', 'rentabilidad_ur_bcu.rds')) %>% 
  filter(administradora %in% c("afap_sura", "integracion",
                               "republica", "union_capital")) %>% 
  mutate(fuente="BCU")
  
# Rentabilidad mensual
rentabilidad_mensual_ur_bcu_plot <- rentabilidad_real_bcu_ur %>% 
  filter(fondo=="Acumulación"|fondo=="Total") %>% 
  ggplot(aes(ano_mes, rentabilidad_ur, color=administradora)) +
  geom_line()

# Rentabilidad Anual
rentabilidad_anual_ur_bcu_plot <- rentabilidad_real_bcu_ur %>% 
  group_by(anio=year(ano_mes), administradora) %>% 
  filter(fondo=="Acumulación"|fondo=="Total") %>% 
  summarize(rentabilidad_ur=mean(rentabilidad_ur)) %>% 
  ggplot(aes(anio, rentabilidad_ur, color=administradora)) +
  geom_line()


# En un solo plot
bind_rows(rentabilidad_real_bcu_ur,
          rename(rentabilidades, 
                 rentabilidad_ur=rentabilidad_ur_simple)) %>% 
  filter(fondo=="Acumulación"|fondo=="Total") %>% 
  ggplot(aes(ano_mes, rentabilidad_ur, color=administradora)) +
  geom_line() +
  facet_wrap(~fuente, ncol=1)
