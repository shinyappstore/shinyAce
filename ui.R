# define UI for application that demonstrates a simple Ace editor
shinyUI(
  div(class="container",
  tags$h2(class="text-danger","Tutorial of the {shinyAce} package with interactive examples"),
  tags$h3(class="text-primary","The shinyAce package enables Shiny application developers to use the Ace text editor in their applications. All current modes (languages) and themes are supported in this package. "),
  br(),br(),
  tabsetPanel(
    tabPanel("Basic",
  pageWithSidebar(
    headerPanel("Simple Shiny Ace!"),
    sidebarPanel(
      selectInput("mode", "Mode: ", choices = modes, selected = "r"),
      selectInput("theme", "Theme: ", choices = themes, selected = "ambience"),
      numericInput("size", "Tab size:", 4),
      radioButtons("soft", NULL, c("Soft tabs" = TRUE, "Hard tabs" = FALSE), inline = TRUE),
      radioButtons("invisible", NULL, c("Hide invisibles" = FALSE, "Show invisibles" = TRUE), inline = TRUE),
      radioButtons("linenr", NULL, c("Show line #" = TRUE, "Hide line #" = FALSE), inline = TRUE),
      actionButton("reset", "Reset text"),
      actionButton("clear", "Clear text"),
      HTML("<hr />"),
      helpText(HTML("A simple Shiny Ace editor.
                  <p>Created using <a href = \"http://github.com/trestletech/shinyAce\">shinyAce</a>."))
    ),
    mainPanel(
      aceEditor(
        outputId = "ace",
        # to access content of `selectionId` in server.R use `ace_selection`
        # i.e., the outputId is prepended to the selectionId for use
        # with Shiny modules
        selectionId = "selection",
        value = init,
        placeholder = "Show a placeholder when the editor is empty ..."
      )
    )
  )),
  tabPanel("Evaluate",
           fluidPage(
             h1("Shiny Ace Evaluate Code"),
             fluidRow(
               column(
                 6,
                 h2("Source Code"),
                 aceEditor("code", mode = "r", height = "200px", value = init2),
                 actionButton("eval", "Evaluate")
               ),
               column(
                 6,
                 h2("Output"),
                 verbatimTextOutput("output")
               )
             )
           )),
  tabPanel("Markdown", fluidPage(
    h1("Shiny Ace knitr Example"),
    fluidRow(
      column(
        6,
        h2("Source R-Markdown"),
        aceEditor("rmd", mode = "markdown", value = init3),
        actionButton("eval", "Update")
      ),
      column(
        6,
        h2("Knitted Output"),
        htmlOutput("knitDoc")
      )
    )
  )),
  tabPanel("Tooltips", fluidPage(
    titlePanel("shinyAce auto completion demo"),
    sidebarLayout(
      sidebarPanel(
        checkboxInput("enableAutocomplete", "Enable R AutoComplete", TRUE),
        checkboxInput("enableTooltips", "Enable R Tooltips", TRUE),
        checkboxInput("enableAnnotations", "Enable R Annotations", TRUE)),
      mainPanel(
        aceEditor("ace_editor",
                  mode = "r",
                  autoComplete = "live",
                  autoCompleters = "rlang",
                  value = "# Tooltips:
# linger over an autocomplete option to view some documentation. See
# - Function descriptions
#     data.fra  # <autocomplete>
# - Argument descriptions
#     data.frame(  # <autocomplete>
# - Package descriptions
#     shinyAc  # <autocomplete>


# Annotations:
# gutter annotations used to indicate syntax errors, try uncommenting this line
# with an incomplete string
# '''


"
        )))
  ))
  ))
)
