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


rentabilidad_nominal_cess <- readRDS(here::here("data", "rentabilidad_nominal_cess_96_14.rds"))%>% 
  filter(administradora %in% c("afap_sura", "integracion",
                               "republica", "union_capital")) %>% 
  select(-valor_cuota)

# Graficar
rentabilidad_nominal_cess  %>% 
  ggplot(aes(ano_mes, rentabilidad_nominal, color=fondo)) +
  geom_line(aes(group=fondo)) + 
  facet_wrap(~administradora) +
  labs(title="Rentabilidad Nominal",
       subtitle="Calculada en base al valor cuota reportado por BCU")

ggsave(here::here('output', 'rentabilidad_nominal_cess.png'))



juntos <- bind_rows(rentabilidad_nominal_bcu,
                    rentabilidad_nominal_cess) %>% 
  arrange(ano_mes, administradora) %>% 
  filter(ano_mes<as.Date("2014-08-01"))

juntos %>% 
  pivot_wider(id_cols=c(ano_mes, administradora),
              names_from=fuente,
              values_from=rentabilidad_nominal) %>% 
  ggplot(aes(BCU, cess)) + 
  geom_point() + 
  facet_wrap(~year(ano_mes), scale="free")

ggsave(here::here('output', 'rentabilidad_nominal.png'))
