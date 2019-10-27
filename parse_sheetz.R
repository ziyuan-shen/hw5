require(rvest)
require(jsonlite)
require(tidyverse)
require(tidyr)

for (i in 1:10) {
  file <- read_html(paste('./data/sheetz/Section ', i, '.html', sep=''))
  content <- file %>%
    html_nodes(css='body') %>%
    html_text()
  df <- content %>%
    fromJSON(flatten=TRUE)
  df_cleaned <- df %>%
    select(-fuelPrice)
  #lapply(unlist) %>%
  #as.data.frame(stringsAsFactors=FALSE)
  df_cleaned <- df_cleaned %>% unnest(cols=colnames(df_cleaned))
  df_cleaned$fuelPrice <- df$fuelPrice[1:nrow(df_cleaned)]
  if (i == 1) {
    df_full <- df_cleaned
  }
  else {
    df_full <- merge(df_full, df_cleaned, all=TRUE)
  }
}

saveRDS(df_full, './data/sheetz/sheetz.Rda')