# Calcula rentabilidades nominales, en UR y en UI a
# partir de valores cuota

valor_cuota_total <- readRDS(file = here::here("data", "rds", "valor_cuota_total.rds"))

ur <- readRDS(here::here('data', 'rds', 'ur.rds'))

rentabilidad_ur_cess <- valor_cuota_total %>% 
  left_join(ur) %>% 
  mutate(
    valor_cuota_ur=valor_cuota/ur
  ) %>% 
  group_by(administradora, fondo) %>% 
  mutate(rentabilidad_ur_indice = 100 * 
         (((valor_cuota_ur/lag(valor_cuota_ur, 36))^(1/3)) - 1)) %>% 
  mutate(rentabilidad_ur_simple= 100 * (valor_cuota_ur/lag(valor_cuota_ur, 12) - 1)) %>% 
  ungroup()

saveRDS(rentabilidad_ur_cess, here::here('data', 'rds', 'rentabilidad_ur_cess.rds'))
  
# Pegar la del BCU para verificar

rentabilidad_ur_bcu <- readRDS(here::here("data", "rds", "rentabilidad_ur_bcu.rds")) %>% 
  filter(administradora %in% c("afap_sura", "integracion",
                               "republica", "union_capital")) %>% 
  filter(fondo=="Acumulación") %>% 
  rename(rentabilidad_ur_bcu=rentabilidad_ur) %>% 
  select(ano_mes, rentabilidad_ur_bcu, administradora)

rentabilidad_ur_comparada <- rentabilidad_ur_cess %>% 
  filter(fondo=="Acumulación") %>% 
  left_join(rentabilidad_ur_bcu, by=c("administradora", "ano_mes"))

sura <- rentabilidad_ur_comparada %>% 
  # filter(administradora %in% c("afap_sura", "integracion",
  #                              "republica", "union_capital")) %>% 
  filter(administradora=="afap_sura")

 
WriteXLS(sura, ExcelFileName = here::here("output", "VerificarRentabilidadUR.xlsx"))
