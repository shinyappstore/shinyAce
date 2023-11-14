# define server logic required to generate simple ace editor
shinyServer(function(input, output, session) {
  observe({
    # print all editor content to the R console
    cat(input$ace, "\n")
  })

  observe({
    # print only selected editor content to the R console
    # to access content of `selectionId` use `ace_selection`
    # i.e., the outputId is prepended to the selectionId for
    # use with Shiny modules
    cat(input$ace_selection, "\n")
  })

  observe({
    updateAceEditor(
      session,
      "ace",
      theme = input$theme,
      mode = input$mode,
      tabSize = input$size,
      useSoftTabs = as.logical(input$soft),
      showInvisibles = as.logical(input$invisible),
      showLineNumbers = as.logical(input$linenr)
    )
  })

  output$output <- renderPrint({
    input$eval
    eval(parse(text = isolate(input$code)))
  })

  observeEvent(input$reset, {
    updateAceEditor(session, "ace", value = init)
  })

  observeEvent(input$clear, {
    updateAceEditor(session, "ace", value = "")
  })

  ace_completer <- aceAutocomplete("ace_editor")
  ace_annotator <- aceAnnotate("ace_editor")
  ace_tooltip   <- aceTooltip("ace_editor")

  # Enabling and Disabling Autocompletion Observer
  observe({
    if (input$enableAutocomplete) ace_completer$resume()
    else ace_completer$suspend()
  })

  # Enabling and Disabling Tooltips Observer
  observe({
    if (input$enableTooltips) ace_tooltip$resume()
    else ace_tooltip$suspend()
  })

  # Enabling and Disabling Annotations Observer
  observe({
    if (input$enableAnnotations) ace_annotator$resume()
    else ace_annotator$suspend()
  })

  output$knitDoc <- renderUI({
    input$eval
    HTML(knitr::knit2html(text = isolate(input$rmd), fragment.only = TRUE, quiet = TRUE))
  })
})
