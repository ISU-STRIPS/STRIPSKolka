require(dplyr)

dissolved_organic_carbon = readr::read_csv("STRIPS1KolkaDOCData2008_2010.csv", na=".") %>%
  dplyr::select(-Treatment,-Block) %>%
  gather(tmp, value, -Watershed) %>%
  separate(tmp, into=c("response","year")) %>%
  mutate(response = plyr::revalue(response, c("DOCConc" = "concentration", # (Mg/L)
                                              "DOCLoad" = "load"))) %>%    # (kg/ha)
  spread(response,value) %>%
  select(year, Watershed, concentration, load) %>%
  arrange(year, Watershed)

names(dissolved_organic_carbon) = tolower(names(dissolved_organic_carbon))

devtools::use_data(dissolved_organic_carbon, overwrite = TRUE)
