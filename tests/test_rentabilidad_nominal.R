library(testthat)
library(lubridate)
library(tibble)
library(dplyr)

rentabilidad_nominal_cess <- readRDS(here::here("data", "rentabilidad_nominal_cess.rds"))

test_that("1997", {
  expected <- tibble(
    ano_mes = as.Date("1997-07-01"),
    administradora=c("afap_sura", "capital", "comercial", 
                     "integracion", "republica", "santander", 
                     "union", "union_capital", "sistema"),
    rentabilidad_nominal = c(NA, 
                             31.5776804461221, 
                             32.4576813881613, 
                             31.2503773107089, 
                             29.1111068333587, 
                             30.2760325504758, 
                             32.555977353292, 
                             NA, 
                             30.1031126230761)
  )
  
  actual <- rentabilidad_nominal_cess %>% 
    filter(year(ano_mes) == 1997, month(ano_mes) ==7) %>% 
    select(ano_mes, administradora, rentabilidad_nominal)
  
  expect_equal(expected, actual, tolerance=.01)
  
})
