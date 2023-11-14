
# shinyAce: Interactively integrate the Ace editor with Shiny 

#### Use app online: __[www.shinyappstore.com/a/shinyAce](https://shinyappstore.com/a/shinyAce)__

The shinyAce package enables Shiny application developers to use the Ace text editor in their applications. All current modes (languages) and themes are supported in this package. The mode, theme, and current text can be defined when the element is initialized in ui.R or afterwards using the updateAceEditor() function. The editor registers itself as a reactive Shiny input, so the current value of the editor can easily be pulled from server.R using input$yourEditorsName.
