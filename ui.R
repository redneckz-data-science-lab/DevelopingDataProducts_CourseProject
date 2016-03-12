shinyUI(fluidPage(
    titlePanel("Singular Value Decomposition", windowTitle="Singular Value Decomposition"),
    fluidPage(
        fluidRow(
            column(width=12,
                   p("This work is aimed to demonstrate data compression aspect of",
                     tags$strong("Singular Value Decomposition"), "method.",
                     "Typically SVD is used for", tags$strong("Principal Components Analysis."),
                     "But here we can see how SVD can be used for picture compression.")
            )
        )
    ),
    sidebarLayout(
        sidebarPanel(
            fileInput("inFile", "Choose PNG", accept=c("image/png")),
            tags$hr(),
            sliderInput("variancePercent", "Select Variance Level", min=1, max=100, value=100),
            tags$hr(),
            p("Steps:"),
            tags$ol(
                tags$li("Load some pictrue in", tags$strong("PNG"), "format.",
                        "It's better to load small pictures for preformance purposes."),
                tags$li("Take a look to the",
                        tags$strong("Singular Values"), "plot and",
                        "choose", tags$strong("Variance Level"),
                        "by slider to reduce number of active components."),
                tags$li(tags$strong("Restored image plot"),
                        "is recomputed according to active components number.",
                        "Less components used, less picture quality.")
            )
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
            fluidPage(
                fluidRow(
                    column(width=6,
                           plotOutput("singularValuesPlot", height="300px")),
                    column(width=6,
                           plotOutput("reducedPicture", height="300px"))
                )
            )
        )
    )
))
