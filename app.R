library(shiny)

ui <- fluidPage(
  tags$head(
    tags$link(href = "https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css", rel = "stylesheet", type = "text/css"),
    tags$link(href = "https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css", rel = "stylesheet", type = "text/css"),
    tags$link(href = "app.css", rel = "stylesheet", type = "text/css"),
    tags$script(src = "https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"),
    tags$script(src = "app.js"),
    tags$script(
      "
      Shiny.addCustomMessageHandler('get_results', function(message) {
      
      // Get an array of text values
      var result = $('#show_selected').find('.is-link').map(function() {
        return $(this).text().trim();
      }).get();
      
      Shiny.setInputValue('selected_result', result);
      });
      
      "
    )
  ),
  fluidRow(
    h1(class = "title is-1 has-text-centered", "Dynamic Multiselect")
  ),
  fluidRow(
    column(
      width = 6,
      tags$select(
        id = "select_widget"
      )
    ),
    column(
      width = 6,
      tags$div(
        id = "show_selected",
        class = "field is-grouped is-grouped-multiline"
      ))
    ),
  fluidRow(
    class = "pl-4",
    actionButton(
      inputId = "btn_submit",
      label = "Submit"
    )
  ),
  fluidRow(
    class = "pl-4",
    uiOutput("display")
  )
)

server <- function(input, output, session) {
  
  Current <- reactiveValues(selection = NULL)
  
  # Updates the select input when the app first loads
  options <- c("Option 1", "Option 2", "Option 3", "Option 4", "Option 5", 
               "Option 6")
  updateSelectInput(
    inputId = "select_widget",
    choices = options,
    selected = ""
  )
  
  # Clicking the submit button will trigger JS to retrieve a list of selected 
  # options
  observeEvent(input$btn_submit, {
    session$sendCustomMessage(type = 'get_results', 
                              message = 'msg')
  })
  
  # Receives list of selected options from JS
  observeEvent(input$selected_result, {
    Current$selection <- input$selected_result
    output$display <- renderText(input$selected_result)
  })
}

shinyApp(ui = ui, server = server)