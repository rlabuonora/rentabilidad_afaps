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
  
  

