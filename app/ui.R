navbarPage(
  title = "QR Code Reader",
  id = "navbar",
  position = "static-top",
  inverse = TRUE,
  tabPanel(
    title = "View QR Code",
    fluidRow(
      tags$style(".irs--square .irs-handle {
                    top: 27px;
                    width: 12px;
                    height: 12px;
                    border: 3px solid #4d4d4d;
                    background-color: white;
                    -webkit-transform: rotate(
                      45deg
                    );
                    -ms-transform: rotate(45deg);
                    transform: rotate(
                      45deg
                    );

                    }"),
      column(
        width = 2,
        bs4Dash::bs4DashSidebar(
          shiny::textInput("text1",
            label = "Write the first number",
            value = ""
          ),
          shiny::textInput("text2",
            label = "Write the second number",
            value = ""
          ),
          shinysense::shinyviewr_UI("my_camera", height = "200px"),
          hr(), hr(), hr(), hr(), hr(), hr(),
          shiny::fileInput("photo",
            label = "Choose an image",
            accept = c("image/jpeg", "image/png"),
            multiple = FALSE
          )
        )
      ),
      column(
        width = 10,
        bs4Dash::bs4DashBody(
          column(6, imageOutput("original")),
          column(
            6, verbatimTextOutput("text1"),
            verbatimTextOutput("text2"),
            tableOutput("values")
          )
        )
      )
    ),
  )
)
