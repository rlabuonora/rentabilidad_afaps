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
                             31.57, 
                             32.45, 
                             31.25, 
                             29.11, 
                             30.27, 
                             32.55, 
                             NA, 
                             30.10)
  )
  
  actual <- rentabilidad_nominal_cess %>% 
    filter(year(ano_mes) == 1997, month(ano_mes) ==7) %>% 
    select(ano_mes, administradora, rentabilidad_nominal)
  
  expect_equal(expected, actual, tolerance=.01)
  
})

test_that("1997", {
  expected <- tibble(
    ano_mes = as.Date("2010-12-01"),
    administradora=c("afap_sura", "capital", "comercial", 
                     "integracion", "republica", "santander", 
                     "union", "union_capital", "sistema"),
    rentabilidad_nominal = c(25.3,	NA,	NA,	
                             23.9,	25.6,	NA,	
                             NA,	24.3,	25.2)
  )
  
  actual <- rentabilidad_nominal_cess %>% 
    filter(year(ano_mes) == 2010, month(ano_mes) ==12) %>% 
    select(ano_mes, administradora, rentabilidad_nominal)
  
  expect_equal(expected, actual, tolerance=.01)
  
})


