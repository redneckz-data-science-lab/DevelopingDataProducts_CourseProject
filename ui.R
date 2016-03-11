shinyUI(fluidPage(
    titlePanel("Singular Value Decomposition", windowTitle="Singular Value Decomposition"),
    fluidPage(
        fluidRow(
            column(width=12,
                   p("TODO: Main Description"),
                   p("......................."),
                   p("......................."),
                   p("......................."))
        )
    ),
    sidebarLayout(
        sidebarPanel(
            fileInput("inFile", "Choose PNG", accept=c("image/png")),
            tags$hr(),
            sliderInput("variancePercent", "Select Variance Level", min=1, max=100, value=100),
            tags$hr()
        ),
        mainPanel(
            fluidPage(
                fluidRow(
                    column(width=6,
                           plotOutput("originalPicture", height="300px")),
                    column(width=6,
                           plotOutput("grayscaledPicture", height="300px"))
                )
            ),
            plotOutput("singularValuesPlot", height="300px"),
            plotOutput("reducedPicture")
        )
    )
));
