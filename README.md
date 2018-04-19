## atv
Analysis of two variables by nonparametric method

### Description
In science and engineering, nonparametric correlation and variance analysis and hypothesis test of variance analysis may be required to verify experimental results.
Statistical analysis software that can be operated with GUI is expensive.
Excel can do parametric hypothesis test only.
You can do nonparametric hypothesis testing by using R or Python, but you need to operate with CUI.
We created a web application using R / Shiny so that scientists and engineers can easily do nonparametric hypothesis tests.

### Launch web application
You can install from R console.
If shiny, tibble, NSM3 and ggplot2 are not installed on your PC, install shiny, tibble, NSM3 and ggplot2 with Internet connection.

    install.packages(c("shiny", "ggplot2", "tibble", "NSM3", "lawstat"))

If shiny is installed, it can be started from R console with the following command.
    
    shiny::runGitHub("atv", "ToshihiroIguchi")
    
For those who have difficulty installing R, I have published it as a web application in [shinyapps.io](https://toshihiroiguchi.shinyapps.io/atvnm/).

### Host
Host the Shiny application from GitHub in a private network.
Enter the following command in R console.

    #Port specification
    port <- 1192

    #Acquire private address information
    ipconfig.dat <- system("ipconfig", intern = TRUE)
    ipv4.dat <- ipconfig.dat[grep("IPv4", ipconfig.dat)][1]
    ip <- gsub(".*? ([[:digit:]])", "\\1", ipv4.dat)

    #Host the Shiny application from GitHub
    shiny::runGitHub("atv", "ToshihiroIguchi", launch.browser = FALSE, port = port, host = ip)

If you are in the private network, you can also launch the Shiny application by entering the URL following `Listing on` to the browser.



### License 

```
MIT License

Copyright (c) 2018 Toshihiro Iguchi

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

### Auther
Toshihiro Iguchi

