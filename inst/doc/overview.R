## ----setup, include=FALSE, eval=TRUE------------------------------------------
# For development, before I implement.
#knitr::opts_chunk$set(eval = FALSE, echo = TRUE)

## -----------------------------------------------------------------------------
library(ctf)

## -----------------------------------------------------------------------------
d <- file.path(tempdir(), "iris_ctf_data")
write.ctf(iris, d)

## -----------------------------------------------------------------------------
list.files(d)

colnames(iris)

## ---- include=FALSE-----------------------------------------------------------
files = list.files(d)

if(!(sum(endsWith(files, ".json")) == 1))
    stop("Expected 1 JSON file with metadata.")

if(!(length(files) == length(iris) + 1))
    stop("Expected files for each column, plus one for metadata.")

## -----------------------------------------------------------------------------
pl_file <- file.path(d, "Petal.Length")
readLines(pl_file, n = 5L)

iris[1:5, "Petal.Length"]

## ---- include=FALSE-----------------------------------------------------------
from_file = readLines(pl_file, n = 5L)
expected = iris[1:5, "Petal.Length"]

if(!all.equal(as.numeric(from_file), expected))
    stop("Data from ctf doesn't match.")

## -----------------------------------------------------------------------------
iris2 <- read.ctf(d)
head(iris2)

# Same thing:
head(iris)

## -----------------------------------------------------------------------------
unlink(d, recursive = TRUE)

