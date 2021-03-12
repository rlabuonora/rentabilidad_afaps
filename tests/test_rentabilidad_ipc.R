library(testthat)
library(lubridate)
library(tibble)
library(dplyr)

rentabilidad_ipc <- readRDS(here::here("data", "rentabilidades_ipc.rds"))


test_that("Antes de 1999 son NA", {
  
  retabilidad_pre_1999 <- rentabilidad_ipc %>% 
    filter(ano_mes<as.Date("1999-06-01")) %>% 
    pull(rentabilidad_ipc)
  
  expect(all(is.na(retabilidad_pre_1999)))
  
})

test_that("Despues de 1999 no hay NA", {
  
  retabilidad_post_1999 <- rentabilidad_ipc %>% 
    filter(ano_mes > as.Date("1999-06-01")) %>% 
    pull(rentabilidad_ipc)
  
  expect(all(!is.na(retabilidad_post_1999)))
  
})
