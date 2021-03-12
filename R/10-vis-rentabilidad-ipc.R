library(tidyverse)
library(patchwork)
library(lubridate)

theme_set(theme_minimal())

rentabilidad_ipc_cess <- readRDS(here::here("data", "rds", "rentabilidad_ipc_cess.rds")) %>% 
  filter(administradora %in% c("afap_sura", "integracion",
                               "republica", "union_capital")) %>% 
  select(ano_mes, rentabilidad_ipc_simple, 
         rentabilidad_ipc_indice, administradora, fondo) %>% 
  mutate(
    administradora= case_when(
      administradora=="afap_sura"~"Sura",
      administradora=="integracion"~"Integración",
      administradora=="republica"~"República",
      administradora=="union_capital"~"Unión Capital",
    )
  )

plot_simple <- rentabilidad_ipc_cess %>% 
  filter(fondo=="Acumulación") %>% 
  ggplot(aes(x=ano_mes, color=administradora)) + 
  geom_line(aes(y=rentabilidad_ipc_simple)) +
  scale_y_continuous(labels=scales::percent_format(scale=1)) +
  scale_color_discrete("")  +
  labs(title="Rentabilidad en UI*",
       caption="* Variación Anual",
       subtitle="Fondo Acumulación",
       x="", y="") + 
  theme(
    legend.position = "bottom",
    text = element_text(size=8),
    plot.title = element_text(hjust=.5),
    plot.subtitle=element_text(hjust=.5)
  )

plot_compuesto <- rentabilidad_ipc_cess %>% 
  filter(fondo=="Acumulación") %>% 
  ggplot(aes(x=ano_mes, color=administradora)) + 
  geom_line(aes(y=rentabilidad_ipc_indice)) +
  scale_y_continuous(labels=scales::percent_format(scale=1)) +
  scale_color_discrete("")  +
  labs(title="Rentabilidad en UI*",
       caption="* Variación de 36 meses anualizada",
       subtitle="Fondo Acumulación",
       x="", y="") + 
  theme(
    legend.position = "bottom",
    text = element_text(size=8),
    plot.title = element_text(hjust=.5),
    plot.subtitle=element_text(hjust=.5)
  )

ggsave(here::here('output', 'rentabilidad_ipc.png'))

