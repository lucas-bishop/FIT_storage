library(tidyverse)
library(readxl)

# for error code in FIT DATA file, make a note
# for measurment column in readings file, make temperature and time label
# output csv file with samples that need to be redone, box, location, time, temp., dilution?


raw_fit_data <- read_csv("6252020-6262020.csv") %>% 
  select("ANALYSIS DATE", "ANALYSIS TIME", "SAMPLE ID", "MEASUREMENT VALUE", "JUDGEMENT", "ERROR CODE")

master_readings <- read_xlsx("FIT_Loc_wReadings.xlsx", range = "B1:O590")

#pull rows that don't have any missing values. then sample ID's that do 
good_rows <- master_readings %>% select(-notes) %>% drop_na() %>% pull(sample_ID) 
#now need dataframe of sample_ID's that have at least one missing
redo_table <- master_readings %>% 
  filter(!master_readings$sample_ID %in% good_rows)
#now depending on which column NA value is in, parse a table with all incubations

A_redo <- redo_table %>% filter(is.na(`Measurement_A (Hb ng/mL)`))
B_redo <- redo_table %>% filter(is.na(`Measurement_B (Hb ng/mL)`))
C_redo <- redo_table %>% filter(is.na(`Measurement_C (Hb ng/mL)`))
D_redo <- redo_table %>% filter(is.na(`Measurement_D (Hb ng/mL)`))
E_redo <- redo_table %>% filter(is.na(`Measurement_E (Hb ng/mL)`))

# paste all redos together ordered by, and with spaces between, each treatment
redo_by_treatment <- rbind(A_redo, B_redo, C_redo, D_redo, E_redo)

write_excel_csv(redo_by_treatment, path = "~/Documents/SchlossLab/FIT_storage/FIT_redos.csv")
