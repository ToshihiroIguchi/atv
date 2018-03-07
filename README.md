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
If shiny, tibble and ggplot2 are not installed on your PC, install shiny, tibble and ggplot2 with Internet connection.

    install.packages(c("shiny", "ggplot2", "tibble"))

If shiny is installed, it can be started from R console with the following command.
    
    shiny::runGitHub("atv", "ToshihiroIguchi")

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

