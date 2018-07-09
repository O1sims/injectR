# `injectoR`: An `R` package for detecting SQLi and XSS attacks in arbitary strings

## Overview

The `injectoR` package provides a number of functions for the detection of SQLi and XSS commands in arbitary strings. This package basically serves as an R wrapper around the highly-regarded package [`libinjection`](https://github.com/client9/libinjection).

## Compiling SQLi and XSS filters to be used in R

From terminal, `cd` into the `src` directory, which contains the `.c` and `.h` files, and use the following commands:
```
R CMD SHLIB libinjection.h libinjection_sqli.c libinjection_sqli.h libinjection_sqli_data.h -o libinjection_sqli
R CMD SHLIB libinjection_xss.c libinjection_html5.c -o libinjection_xss
```
This creates two objects, called `libinjection_sqli` and `libinjection_xss`, which can be called by R.
