shiny::shinyServer(function(input, output, session) {
  output$text1 <- renderPrint({
    input$text1
  })
  output$text2 <- renderPrint({
    input$text2
  })

  my_camera <- callModule(
    shinyviewr, "myCamera",
    output_height = 300,
    output_width = 400
  )

  observeEvent(myCamera(), {
    photo <- myCamera()
    png(filename = "../photos/cam.png")
    plot(as.raster(photo))
    dev.off()
    output$snapshot <- renderPlot({
      plot(as.raster(photo))
    })
  })

  prg <- eventReactive(input$photo, {
    Progress$new(session, min = 0, max = 1)
  })

  mgk <- eventReactive(input$photo, {
    prg()$set(message = "Reading image", value = 0.3)
    image_read(input$photo$datapath[1])
  })

  output$original <- renderPlot({
    image_ggplot(mgk())
  })
  decoded_reactive <- reactive({
    prg()$set(value = 0.6, message = "Starting to decode")
    decoded_object <- qr_scan(mgk(), flop = FALSE)
    prg()$set(value = 0.9, message = "Rendering", detail = "")
    prg()$close()

    decoded_object
  })

  output$values <- renderTable(decoded_reactive()$values, digits = 0)
})
