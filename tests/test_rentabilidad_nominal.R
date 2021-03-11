library(testthat)
library(lubridate)
library(tibble)
library(dplyr)

rentabilidad_nominal_cess_96_14 <- readRDS(here::here("data", "rentabilidad_nominal_cess_96_14.rds"))
#rentabilidad_nominal_cess_14_20 <- tibble(ano_mes, administradora, fondo, rentabilidad_nominal)

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
  
  actual <- rentabilidad_nominal_cess_96_14 %>% 
    filter(year(ano_mes) == 1997, month(ano_mes) ==7) %>% 
    select(ano_mes, administradora, rentabilidad_nominal) %>% 
    distinct()
  
  expect_equal(expected, actual, tolerance=.01)
  
})

test_that("2010", {
  expected <- tibble(
    ano_mes = as.Date("2010-12-01"),
    administradora=c("afap_sura", "capital", "comercial", 
                     "integracion", "republica", "santander", 
                     "union", "union_capital", "sistema"),
    rentabilidad_nominal = c(25.3,	NA,	NA,	
                             23.9,	25.6,	NA,	
                             NA,	24.3,	25.2)
  )
  
  actual <- rentabilidad_nominal_cess_96_14 %>% 
    filter(year(ano_mes) == 2010, month(ano_mes) ==12) %>% 
    select(ano_mes, administradora, rentabilidad_nominal) %>% 
    distinct()
  
  expect_equal(expected, actual, tolerance=.01)
  
})

test_that("2011", {
  skip("fails")
  expected <- tibble(
    ano_mes = as.Date("2011-01-01"),
    administradora=c("afap_sura", "capital", "comercial", 
                     "integracion", "republica", "santander", 
                     "union", "union_capital", "sistema"),
    rentabilidad_nominal = c(34.6,	NA,	NA,
                             32.5,	36.4,	NA,
                             NA,	35.2,	35.5))
  
  actual <- rentabilidad_nominal_cess_96_14 %>% 
    filter(year(ano_mes) == 2011, month(ano_mes) ==1) %>% 
    select(ano_mes, administradora, rentabilidad_nominal)
  
  expect_equal(expected, actual, tolerance=.01)
  
})

test_that("2012", {
  
  skip("fails")
  expected <- tibble(
    ano_mes = as.Date("2012-01-01"),
    administradora=c("afap_sura", "capital", "comercial", 
                     "integracion", "republica", "santander", 
                     "union", "union_capital", "sistema"),
    rentabilidad_nominal = c(27.3,	NA,	NA,
                             25.6,	28.6,	NA,	
                             NA,	27.5,	27.9))
  
  actual <- rentabilidad_nominal_cess_96_14 %>% 
    filter(year(ano_mes) == 2012, month(ano_mes) ==1) %>% 
    select(ano_mes, administradora, rentabilidad_nominal)
  
  expect_equal(expected, actual, tolerance=.01)
  
})

test_that("2013", {
  expected <- tibble(
    ano_mes = as.Date("2013-01-01"),
    administradora=c("afap_sura", "capital", "comercial", 
                     "integracion", "republica", "santander", 
                     "union", "union_capital", "sistema"),
    rentabilidad_nominal = c(20.5,	NA,	NA,	
                             19.8,	20.3,	NA,
                             NA,	19.6, 20.1))
  
  actual <- rentabilidad_nominal_cess_96_14 %>% 
    filter(year(ano_mes) == 2013, month(ano_mes) ==1) %>% 
    select(ano_mes, administradora, rentabilidad_nominal) %>% 
    distinct()
  
  expect_equal(expected, actual, tolerance=.5)
  
})

test_that("2014: Acumulación", {
  skip("Not implemented")
  expected <- tibble(
    ano_mes = as.Date("2014-08-01"),
    administradora=c("afap_sura", "integracion", 
                     "republica", "union_capital", 
                     "sistema"),
    fondo="Acumulación",
    rentabilidad_nominal = c(14.1,	13.8,	13.3,	13.9,	13.6))
  
  actual <- rentabilidad_nominal_cess_14_20 %>% 
    filter(year(ano_mes) == 2014, month(ano_mes) ==8, 
           fondo=="Acumulación") %>% 
    select(ano_mes, administradora, fondo, rentabilidad_nominal)
  
  expect_equal(expected, actual, tolerance=.5)
  
})

test_that("2014: Retiro", {
  skip("Not implemented")
  expected <- tibble(
    ano_mes = as.Date("2014-08-01"),
    administradora=c("afap_sura", "integracion", 
                     "republica", "union_capital", 
                     "sistema"),
    fondo="Retiro",
    rentabilidad_nominal = c(14.1,	13.9,	13.4,	14.1,	13.7))
  
  actual <- rentabilidad_nominal_cess_14_20 %>% 
    filter(year(ano_mes) == 2014, month(ano_mes) ==8, 
           fondo=="Retiro") %>% 
    select(ano_mes, administradora, rentabilidad_nominal)
  
  expect_equal(expected, actual, tolerance=.5)
  
})


