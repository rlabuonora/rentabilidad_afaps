## Calcula las rentabilidades usando el ipc

# Cargar IPC
ipc <- readRDS(here::here('data', 'ipc.rds'))

# Cargar valores cuota 
# En el periodo antes de 2014 uso total para Retiro y Acumulacion
valor_cuota <- readRDS(here::here('data', 'valor_cuota_total.rds'))

rentabilidades_ipc <- valor_cuota %>% 
  # pegar ipc
  left_join(ipc, by="ano_mes") %>% 
  # calcular valor cuota/ipc
  mutate(valor_cuota_ipc = valor_cuota/ipc) %>% 
  group_by(administradora, fondo) %>% 
  # Aplicar formula del indice de rentabilidad
  mutate(rentabilidad_ipc=
           (valor_cuota_ipc/lag(valor_cuota_ipc, 36))^(1/3))

# Salvar
saveRDS(rentabilidades_ipc, here::here('data', 'rentabilidades_ipc.rds'))