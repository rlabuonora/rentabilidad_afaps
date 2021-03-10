library(ggplot2)

rentabilidad_nominal_bcu <- readRDS(here::here("data", "rentabilidad_nominal_bcu.rds"))%>% 
  filter(administradora %in% c("afap_sura", "integracion",
                               "republica", "union_capital"))

rentabilidad_nominal_bcu  %>%
  ggplot(aes(ano_mes, rentabilidad_nominal, color=fondo)) +
  geom_line(aes(group=fondo)) + 
  facet_wrap(~administradora) +
  labs(title="Rentabilidad Nominal", 
       subtitle="Reportada por BCU")

ggsave(here::here('output', 'rentabilidad_nominal_bcu.png'))


rentabilidad_nominal_cess <- readRDS(here::here("data", "rentabilidad_nominal_cess.rds"))%>% 
  filter(administradora %in% c("afap_sura", "integracion",
                               "republica", "union_capital"))

# Graficar
rentabilidad_nominal_cess  %>% 
  ggplot(aes(ano_mes, rentabilidad_nominal, color=fondo)) +
  geom_line(aes(group=fondo)) + 
  facet_wrap(~administradora) +
  labs(title="Rentabilidad Nominal",
       subtitle="Calculada en base al valor cuota reportado por BCU")

ggsave(here::here('output', 'rentabilidad_nominal_cess.png'))


# Pegar para graficar
rentabilidad_nominal_comparada <- rentabilidad_nominal_cess %>%
  select(ano_mes, administradora, rentabilidad_nominal, fondo) %>% 
  mutate(rentabilidad_nominal = rentabilidad_nominal * 100 ) %>% 
  left_join(select(rentabilidad_nominal_bcu, 
                   fondo, ano_mes, rentabilidad_nominal), 
            by=c("ano_mes", "administradora")) %>% 
  mutate(diff=rentabilidad_nominal.x-rentabilidad_nominal.y)




ggsave(here::here("output", "rentabilidad_bruta_scatter.png"))


