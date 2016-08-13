library(shiny)

# Use multi-page user-interface with the navigation bar
shinyUI(
    
    navbarPage("TRIZ Scope",
               
        tabPanel("Word cloud",
            sidebarPanel(
                p("Explore how the changing the scope of application of TRIZ
                  is reflected in the content of the articles 
                  of site 'The TRIZ Journal'"),
                selectInput("selection", 
                            "Choose a period of publication of articles:",
                            choices = sets),
                actionButton("update", "Change"),
                hr(),
                sliderInput("freq",
                            "Minimum Frequency:",
                            min = 1,  max = 100, value = 20),
                sliderInput("max",
                            "Maximum Number of Words:",
                            min = 1,  max = 250,  value = 100)
            ),
            
            mainPanel(
                plotOutput("plot")
            )
        ), # end of tabPanel "Word cloud"
        
        tabPanel("About",
            mainPanel(
                includeMarkdown("about.md")
            )
        ) 
    )
)