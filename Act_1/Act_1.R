library(polite)
library(dplyr)
library(rvest)
library(httr)

polite::use_manners(save_as = 'polite_scrape.R')

scrape_category <- function(url, max_items = 25) {
  scraped_page <- scrape(bow(url, user_agent = "Educational"))
  
  brand_des <- scraped_page %>%
    html_nodes('.a-size-medium.a-color-base.a-text-normal') %>%
    html_text()
  
  price <- scraped_page %>%
    html_nodes('span.a-offscreen') %>%
    html_text()
  
  num_of_rev <- scraped_page %>%
    html_nodes('span.a-size-base') %>%
    html_text()
  
  review_stars <- scraped_page %>%
    html_nodes('span.a-icon-alt') %>%
    html_text()
  
  min_length <- min(length(brand_des), length(price), length(num_of_rev), length(review_stars), max_items)
  
  category_data <- data.frame(
    Brand_Description = brand_des[1:min_length],
    Price = price[1:min_length],
    Number_of_Reviews = num_of_rev[1:min_length],
    Review_Stars = review_stars[1:min_length]
  )
  
  return(category_data)
}

url_category1 <- 'https://www.amazon.com/TIMJYUT-Permanent-Oil-Based-Waterproof-Markers/dp/B0CQCCBNY8/ref=sr_1_1_sspa?qid=1707542123&s=arts-crafts-intl-ship&sr=1-1-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9hdGZfYnJvd3Nl&psc=1'
url_category2 <- 'https://www.amazon.com/BANDQ-Protector%E3%80%903-Bubble-Free-Installation-Scratch-Resistant/dp/B0CKSVBLXD/ref=sr_1_1_sspa?qid=1707546441&s=electronics&sr=1-1-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9hdGZfYnJvd3Nl&psc=1'

category1_data <- scrape_category(url_category1)
category2_data <- scrape_category(url_category2)

merged_data <- bind_rows(
  mutate(category1_data, Category = 'Art'),
  mutate(category2_data, Category = 'Accesories and Supply')
)

write.csv(merged_data, file = "amazon_products.csv", row.names = FALSE)

print(merged_data)
