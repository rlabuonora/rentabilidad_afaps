## Calcula las rentabilidades usando el ipc

# Cargar IPC
ipc <- readRDS(here::here('data', 'rds', 'ipc.rds'))

# Cargar valores cuota 
# En el periodo antes de 2014 uso total para Retiro y Acumulacion
valor_cuota_total <- readRDS(here::here('data', 'rds', 'valor_cuota_total.rds'))

rentabilidad_ipc_cess <- valor_cuota_total %>% 
  # pegar ipc
  left_join(ipc, by="ano_mes") %>% 
  # calcular valor cuota/ipc
  mutate(valor_cuota_ipc = valor_cuota/ipc) %>% 
  group_by(administradora, fondo) %>% 
  # Aplicar formula del indice de rentabilidad
  mutate(rentabilidad_ipc_indice =
           (valor_cuota_ipc/lag(valor_cuota_ipc, 36))^(1/3)) %>% 
  mutate(rentabilidad_ipc_simple =
           100 * (valor_cuota_ipc/lag(valor_cuota_ipc, 12) - 1))

# Salvar
saveRDS(rentabilidad_ipc_cess, 
        here::here('data', 'rds', 'rentabilidad_ipc_cess.rds'))
