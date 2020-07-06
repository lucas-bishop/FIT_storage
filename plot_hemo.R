library(tidyverse)
library(RColorBrewer)
library(readxl)

box3_barcodes <- read_excel("FIT_Loc_wReadings_wtemptime.xlsx") %>% 
  filter(box_number == 3) %>% 
  select(sample_ID, Barcode_A, Barcode_B, Barcode_C, Barcode_D, Barcode_E) %>% 
  pivot_longer(-sample_ID, names_to = 'barcode')

box3_readings <- read_excel("FIT_Loc_wReadings_wtemptime.xlsx") %>% 
  filter(box_number == 3) %>% 
  select(sample_ID, Measurement_A, Measurement_B, 
         Measurement_C, Measurement_D, Measurement_E) %>% 
  pivot_longer(-sample_ID, values_to = 'reading')

box3_temptime <- read_excel("FIT_Loc_wReadings_wtemptime.xlsx") %>% 
  filter(box_number == 3) %>% 
  select(sample_ID, hour_A, hour_B, 
         hour_C, hour_D, hour_E, temperature_A, temperature_B, 
         temperature_C, temperature_D, temperature_E) %>% 
  pivot_wider(-sample_ID, names_from = values_from = )


box3 <- inner_join(box3_barcodes, box3_readings)

