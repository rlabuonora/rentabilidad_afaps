# Calcula rentabilidades nominales, en UR y en UI a
# partir de valores cuota

valor_cuota_total <- readRDS(file = here::here("data", "valor_cuota_total.rds"))

ui_mensual <- readRDS(here::here('data', 'ui_mensual.rds'))
ur <- readRDS(here::here('data', 'ur.rds'))

rentabilidades <- valor_cuota_total %>% 
  left_join(ur) %>% 
  mutate(
    valor_cuota_ur=valor_cuota/ur
  ) %>% 
  group_by(administradora, fondo) %>% 
  # rentabilidad nominal
  mutate(rentabilidad_nominal_cagr = 100 * 
           (((valor_cuota/lag(valor_cuota, 36))^(1/3)) - 1)) %>% 
  mutate(rentabilidad_nominal_simple= 100 * (valor_cuota/lag(valor_cuota, 12) - 1)) %>% 
  # rentabilidad en ur
  mutate(rentabilidad_ur_cagr = 100 * 
         (((valor_cuota_ur/lag(valor_cuota_ur, 36))^(1/3)) - 1)) %>% 
  mutate(rentabilidad_ur_simple= 100 * (valor_cuota_ur/lag(valor_cuota_ur, 12) - 1)) %>% 
  ungroup()

saveRDS(rentabilidades, here::here('data', 'rentabilidades.rds'))
  
  

