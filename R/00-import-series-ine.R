library(readxl)
library(tidyverse)

ur <- read_xls(here::here('data', 'xls', 'ur.xls'), range="A7:B637") %>% 
  clean_names() %>% 
  rename(ano_mes=1, ur=2) %>% 
  mutate(ano_mes=as.Date(ano_mes))

saveRDS(ur, here::here("data", "rds", "ur.rds"))


ipc <- read_xls(here::here('data', 'xls', 'ipc.xls'),
                range="A11:B1014",
                col_names=c("ano_mes", "ipc"),
                col_type=c("date", "numeric")) %>% 
  mutate(ano_mes=as.Date(ano_mes))


saveRDS(ipc, here::here("data", "rds", "ipc.rds"))
         