#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)
library(googlesheets4)
googlesheets4::gs4_deauth()

reviewers <- googlesheets4::read_sheet(url)
reviewers <- reviewers[-1, ] # "------" row
reviewers$username <- unlist(reviewers$username)
reviewers$username <- paste0("<a href='https://github.com/", reviewers$username, "'>", reviewers$username, "</a>")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$reviewers = DT::renderDataTable({
        DT::datatable(reviewers, 
                      filter = "top",
                      escape = FALSE,
                      options = list(pageLength = 20,
                                     search = list(regex = TRUE)))
    })

})
