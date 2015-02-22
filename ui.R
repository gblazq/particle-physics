# ui.R
library(shiny)

shinyUI(fluidPage(
    titlePanel("Particle physics model fitting"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("mean", "Select the mean (mass in MeV/c^2):", 4300, 6300, 4700),
            sliderInput("f", "Select the fraction of valid observations:",
                        0.00, 1.00, 1.00),
            radioButtons("sigmas", "Select the number of standard deviations of the error bars",
                        list(1, 2, 3)),
#             radioButtons("yaxis", "Select the style of the y axis",
#                          list("Linear", "Square root"), "Linear"),
            strong("Goodness of fit"),
            checkboxInput("chisquared", "Show Pearson's chi-square test value", value = FALSE)),
        mainPanel(
            tabsetPanel(
                tabPanel("App", plotOutput("plot")),
                tabPanel("Help",
                         h3("The app"),
                         HTML("This app creates a histogram of invariant mass of candidates to B<sup>0</sup> -> K<sup>-</sup>&#960;<sup>+</sup>&gamma; disintegrations. Superimposed on the histogram, a simulated density function is shown. The density function is calculated according to a model with two contributions: an unknown fraction of the candidates are real disintegrations and the rest are noise.
The real disintegrations are known to follow a normal distribution with &sigma; = 100 MeV/c<sup>2</sup> centered at the mass of the B<sup>0</sup> meson, and the noise is modelled by an exponential distribution with finite support and rate = 1/1000."),
h3("How to use it"),
HTML("By using the sliders to choose the mean and the fraction of valid observations you should be able to fit the model density function to the observational data. The mean of the normal distribution is the rest mass of the  K<sup>-</sup>&#960;<sup>+</sup>&gamma; products of the disintegration, and according to special relativity and the conservation of energy, it must also be the invariant mass of the B<sup>0</sup> meson. With a fraction of valid observations equal to 1, the model is a gaussian distribution; while a fraction equal to 0 corresponds to a pure noisy model."),
tags$br(), tags$br(),
HTML("You can also select the number of standard deviations of the histogram error bars. When fitting the model, it is important to fit not only the peak of the histogram but also the tails. With one standard deviation, if your model is perfect, you should expect it to be inside the error bars with a confidence of 68%. You can change the standard deviation of the error bars to 2 (95%) or 3 (99.7%)."),
tags$br(), tags$br(),
HTML("Finally, you may want to show the Pearson's chi squared test value. The better your model is, the lower its value will be. By minimizing the chi squared value you can find the two parameters (mean and fraction of valid observations) that fit the experimental histogram."),
tags$br(), tags$br(),
HTML("Once you have found the rest mass of the B<sup>0</sup> that bests fit the histogram, you can check out if your value is consistent with the current known value <a href='https://en.wikipedia.org/wiki/B_meson'>here</a>."),
h3("The data"),
HTML("This app uses data from the LHCb experiment at the LHC particle collider. Data from the LHCb can be downloaded from the <a href='http://opendata.cern.ch/'>CERN Open data portal</a>, but the data is in ROOT format and must be preprocessed."))))
        )
))
