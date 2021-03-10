library(scales)

# valor cuota -> rentabilidad nominal

# La rentabilidad bruta nominal para un período se determina como 
# el cociente entre el valor cuota promedio del período y 
# el valor cuota promedio del período anterior. 
# Este dato se determina para diferentes períodos: 
# mensual, anual y para los últimos cinco años de vigencia del sistema.
# Estos guarismos se toman como 
# insumo para el cálculo de las rentabilidades reales. 

load(here::here('data', 'series.RData'))


# Capital: BCU ANUAL
rentabilidad_nominal %>% 
  select(ano_mes, capital)

# Elaboracion Propia
valor_cuota %>% 
  select(ano_mes, capital) %>% 
  mutate(rent_nominal_capital= capital/lag(capital, 12) - 1,
         rentabilidad        = percent_format(accuracy=0.1)(rent_nominal_capital)) %>% 
  filter(year(ano_mes) == 1997)
