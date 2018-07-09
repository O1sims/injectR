# injectoR

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build Status](https://travis-ci.com/O1sims/injectoR.svg?branch=master)](https://travis-ci.com/O1sims/injectoR)

## 1 Overview

The `injectoR` package provides a number of functions for the detection of SQLi and XSS commands in arbitary strings.

### 1.1 Versions

No versions have been officially released yet. Currently we are still beta testing and adding new functionality, however we will post any new versions here when realeased.

### 1.2 Installation

There is no CRAN version available yet. Instead, consider the following installation instructions for `devtools`.

    # install.packages("devtools")
    library(devtools)
    devtools::install_github("O1sims/injectoR")
    
## 2 Examples

Below we provide examples for the detection of both SQLi and XSS.

### 2.1 SQL injection

```
> results <- "SELECT * FROM items WHERE owner = 'wiley' AND itemname = 'name' OR 'a'='a';" %>%
    injectoR::detectAttack()
> results$isSQLi
[1] 1
> results$fingerprint
[1] Eoknk
```

### 2.2 XSS

```
> results <- 'http://mysite.com/pictures/search.php?query=<script src="http://malicious.com/evil.js"></script>' %>%
    injectoR::detectAttack()
> results$isXSS
[1] 1
> results$fingerprint
[1] sn:oo
```

## 3 Compiling SQLi and XSS filters

Binary files for the filters should be contained in the repo and package. However, if they are not compiled, or need to be recompiled, then they can be by following the instructions. From terminal, `cd` into the `src` directory, which contains the `.c` and `.h` files, and use the following commands:
```
R CMD SHLIB libinjection.h libinjection_sqli.c libinjection_sqli.h libinjection_sqli_data.h -o libinjection_sqli
R CMD SHLIB libinjection_xss.c libinjection_html5.c -o libinjection_xss
```
This creates two objects, called `libinjection_sqli` and `libinjection_xss`, which can be called by R.

## 4 Contact

The best way to troubleshoot or ask for a new feature or enhancement is to create a Github [issue](https://github.com/O1sims/injectoR/issues). However, if you have any further questions you can contact [me](mailto:sims.owen@gmail.com) directly.
