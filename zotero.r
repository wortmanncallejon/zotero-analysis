pacman::p_load(dplyr, ggplot2, readr, lubridate)

read_csv("library.csv", show_col_types = FALSE) |>
    mutate(`Date Added` = as.Date(`Date Added`)) |>
    arrange(`Date Added`) |>
    summarise(n = n(),
              .by = `Date Added`) |>
    mutate(stock = cumsum(n)) |>
    #filter(`Date Added` > as.Date("2024-09-01")) |>
    ggplot(aes(`Date Added`, stock)) +
    scale_y_continuous("Titles in Zotero library", labels = scales::label_comma(1)) +
    #scale_x_date("Date", date_breaks = "1 month", date_labels = "%d. %b %Y") +
    scale_x_date("Date", date_breaks = "1 year", date_labels = "%d. %b %Y") +
    geom_line() +
    theme_light()

ggsave("zotero.png", width = 16, height = 9, units = "cm")
