require(rvest)

file <- read_html("http://www2.stat.duke.edu/~sms185/data/fuel/bystore/zteehs/regions.html")
elements <- file %>% html_nodes(css=".col-md-2 a")
for (i in seq_along(elements)) {
  section_name <- elements[[i]] %>% html_text()
  if (grepl('Section', section_name)) {
    section_url <- elements[[i]] %>% html_attr('href')
    download.file(url=section_url, destfile=paste('./data/sheetz/', section_name, '.html', sep=''))
    Sys.sleep(10)
  }
}