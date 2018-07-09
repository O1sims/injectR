# injectoR

[![Build Status](https://travis-ci.com/O1sims/injectoR.svg?branch=master)](https://travis-ci.com/O1sims/injectoR)

## Overview

The `injectoR` package provides a number of functions for the detection of SQLi and XSS commands in arbitary strings.

## Compiling SQLi and XSS filters to be used in R

From terminal, `cd` into the `src` directory, which contains the `.c` and `.h` files, and use the following commands:
```
R CMD SHLIB libinjection.h libinjection_sqli.c libinjection_sqli.h libinjection_sqli_data.h -o libinjection_sqli
R CMD SHLIB libinjection_xss.c libinjection_html5.c -o libinjection_xss
```
This creates two objects, called `libinjection_sqli` and `libinjection_xss`, which can be called by R.
