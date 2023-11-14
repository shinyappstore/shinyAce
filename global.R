library(shiny)
library(shinyAce)

modes <- getAceModes()
themes <- getAceThemes()

init <- "createData <- function(rows) {
  data.frame(col1 = 1:rows, col2 = rnorm(rows))
}"

init2 <- "
library(quickcode)

createData <- function(rows) {
  data.frame(col1 = number(rows), col2 = number(rows,3))
}

createData(10)
"
init3 <- "### Sample knitr Doc

This is some markdown text. It may also have embedded R code
which will be executed.

```{r}
2*3
rnorm(5)
```

It can even include graphical elements.

```{r}
hist(rnorm(100))
```
"
