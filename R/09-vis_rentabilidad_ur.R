library(tidyverse)
library(patchwork)
library(lubridate)

theme_set(theme_minimal())

rentabilidad_ur_bcu <- readRDS(here::here("data", "rds", "rentabilidad_ur_bcu.rds")) %>% 
  filter(administradora %in% c("afap_sura", "integracion",
                               "republica", "union_capital")) %>% 
  filter(fondo=="Acumulación") %>% 
  select(ano_mes, rentabilidad_ur, administradora, fuente)

rentabilidad_ur_cess <- readRDS(here::here("data", "rds", "rentabilidad_ur_cess.rds")) %>% 
  filter(administradora %in% c("afap_sura", "integracion",
                               "republica", "union_capital")) %>% 
  filter(fondo=="Acumulación") %>% 
  select(ano_mes, rentabilidad_ur_simple, 
         rentabilidad_ur_indice, administradora) 

rentabilidad_ur_cess <- pivot_longer(rentabilidad_ur_cess, 
                                     cols=c(rentabilidad_ur_simple, 
                                            rentabilidad_ur_indice),
                                     names_to="fuente",
                                     values_to="rentabilidad_ur")

df <- bind_rows(
  rentabilidad_ur_bcu,
  rentabilidad_ur_cess
) %>% 
  mutate(
    administradora= case_when(
      administradora=="afap_sura"~"Sura",
      administradora=="integracion"~"Integracion",
      administradora=="republica"~"República",
      administradora=="union_capital"~"Unión Capital",
    ),
    fuente = case_when(
      fuente=="BCU"~ "BCU",
      fuente== "rentabilidad_ur_simple"~"Indice Simple",
      fuente=="rentabilidad_ur_indice"~"Capitalización Compuesta"
    )
  ) %>% 
  ggplot(aes(x=ano_mes, color=administradora)) + 
  geom_line(aes(y=rentabilidad_ur)) +
  scale_x_date(date_breaks="2 years", date_labels='%Y') +
  facet_wrap(~fuente, ncol=1) +
  scale_y_continuous(labels=scales::percent_format(scale=1)) +
  scale_color_discrete("") +
  geom_vline(xintercept = as.Date("2014-01-01"), 
             linetype="dashed",
             color="gray") +
  labs(title="Rentabilidad en UR", x="", y="") + 
  theme(
    legend.position = "bottom",
    text = element_text(size=6)
  )


ggsave(here::here('output', 'rentabilidad_ur.png'))

