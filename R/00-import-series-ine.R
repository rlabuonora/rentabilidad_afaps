library(readxl)
library(tidyverse)

ur <- read_xls(here::here('data', 'ur.xls'), range="A7:B637") %>% 
  clean_names() %>% 
  rename(ano_mes=1, ur=2)

saveRDS(ur, here::here("data", "ur.rds"))


ui <- read_xls(here::here('data', 'ui.xls'), range="A7:B6890") %>% 
  clean_names() %>% 
  rename(ano_mes=1, ui=2) %>% 
  # mensuales
  group_by(year=year(ano_mes), mes=month(ano_mes)) %>% 
  summarize(ui_promedio_mensual=mean(ui)) %>% 
  ungroup() %>% 
  mutate(ano_mes=ym(paste0(year, str_pad(mes, 2, "left", "0")))) %>% 
  select(ano_mes, ui_promedio_mensual)

saveRDS(ui, here::here("data", "ui_mensual.rds"))


ipc <- read_xls(here::here('data', 'ipc.xls'),
                range="A11:B1014",
                col_names=c("ano_mes", "ipc"),
                col_type=c("date", "numeric")) %>% 
  mutate(ano_mes=as.Date(ano_mes))


saveRDS(ipc, here::here("data", "ipc.rds"))
         