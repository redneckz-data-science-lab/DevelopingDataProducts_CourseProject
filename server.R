library("png")

shinyServer(
    function(input, output) {
        inImg <- reactive({
            inFile <- input$inFile
            if (!is.null(inFile)) {
                readPNG(inFile$datapath)
            }
        })
        
        inGrayscaled <- reactive({
            toGrayscale <- function (rgb) {
                if (length(rgb) >= 3) {
                    res <- sum(c(0.299, 0.587, 0.114) * rgb[1:3])
                    if (length(rgb) == 4) {
                        return(res * rgb[4])
                    } else {
                        return(res)
                    }
                } else {
                    return(rgb[1])
                }
            }
            
            img <- inImg()
            if (is.null(img)) {
                return(NULL)
            }
            
            matrix(apply(img, c(1, 2), toGrayscale), nrow=nrow(img))
        })
        
        inDecomposed <- reactive({
            grayscale <- inGrayscaled()
            if (is.null(grayscale)) {
                return(NULL)
            }
            
            svd(grayscale)
        })
        
        inRank <- reactive({
            decomposed <- inDecomposed()
            variancePercent <- as.numeric(input$variancePercent) / 100
            max(2, round(length(decomposed$d) * variancePercent))
        })
        
        inReduced <- reactive({
            decomposed <- inDecomposed()
            if (is.null(decomposed)) {
                return(NULL)
            }
            
            rank <- inRank()
            reduced <- decomposed$u[, 1:rank] %*%
                        diag(decomposed$d[1:rank]) %*%
                        t(decomposed$v[, 1:rank])
            apply(reduced, c(1, 2), function (color) {
                return(max(0, min(1, color)))
            })
        })
        
        output$originalPicture <- renderPlot({
            img <- inImg()
            if (is.null(img)) {
                return(NULL)
            }
            
            plot(0, 0, xlim=c(0, 1), ylim=c(0, 1), main="Original Image",
                 xlab="", ylab="")
            rasterImage(img, 0, 0, 1, 1)
        })
        
        output$grayscaledPicture <- renderPlot({
            grayscales <- inGrayscaled()
            if (is.null(grayscales)) {
                return(NULL)
            }
            
            plot(0, 0, xlim=c(0, 1), ylim=c(0, 1), main="Grayscaled Image",
                 xlab="", ylab="")
            rasterImage(grayscales, 0, 0, 1, 1)
        })
        
        output$singularValuesPlot <- renderPlot({
            decomposed <- inDecomposed()
            if (is.null(decomposed)) {
                return(NULL)
            }
            
            rank <- inRank()
            x <- 1:length(decomposed$d)
            y <- decomposed$d^2 / sum(decomposed$d^2)
            plot(x, y, main="Singular Values (Variance)",
                 col=ifelse(x <= rank, "red", "black"),
                 xlab="", ylab="", pch = 19)
        })
        
        output$reducedPicture <- renderPlot({
            reduced <- inReduced()
            if (is.null(reduced)) {
                return(NULL)
            }
            
            plot(0, 0, xlim=c(0, 1), ylim=c(0, 1), main="Restored/Reduced Image",
                 xlab="", ylab="")
            rasterImage(reduced, 0, 0, 1, 1)
        })
    }
)
