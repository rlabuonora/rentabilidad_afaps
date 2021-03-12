library(testthat)
library(lubridate)
library(tibble)
library(dplyr)

rentabilidades <- readRDS(here::here("data", "rentabilidades.rds"))

test_that("Acumulacion 12 2020", {
  expected <- tibble(
    ano_mes = as_datetime("2020-12-01"),
    administradora=c("afap_sura", 
                     "integracion", "republica",
                     "union_capital", "sistema"),
    rentabilidad_nominal_cagr=c(14.3,	13.8,	13.8,	13.7,	13.9),
    rentabilidad_ur_cagr = c(5.7,	5.3,	5.2,	5.2,	5.3)
  )
  
  actual <- rentabilidades %>% 
    filter(year(ano_mes) == 2020, 
           month(ano_mes) ==12,
           fondo=="Acumulación") %>% 
    select(ano_mes, administradora, 
           rentabilidad_nominal_cagr,
           rentabilidad_ur_cagr)
  
  expect_equal(expected, actual, tolerance=.01)
  
})


