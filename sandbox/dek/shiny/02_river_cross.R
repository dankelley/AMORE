# vim:textwidth=80:expandtab:shiftwidth=4:softtabstop=4

library(shiny)
library(deSolve) # for lsoda()

# Utility functions
timeFormat <- function(t)
{
    if (t < 10) sprintf("%.1f sec", t)
    else if (t < 60) sprintf("%.0f sec", t)
    else if (t < 5*60) sprintf("%.2f min", t/60)
    else if (t < 60*60) sprintf("%.1f min", t/60)
    else sprintf("%.1f hour", t/60/60)
}

heading2theta <- function(heading)
    (90 - heading) * pi / 180

# User Interface
ui <- fluidPage(titlePanel(title="", windowTitle="River Transit"),
    tags$script('$(document).on("keypress", function (e) { Shiny.onInputChange("keypress", e.which); Shiny.onInputChange("keypressTrigger", Math.random()); });'),
    style="text-indent:1em; background:#e6f3ff",
    fluidRow(
        column(3, sliderInput("ur", value=0.0, min=0.0, max=2.0, step=0.01,
                label="River Eastward Speed [m/s]")),
        column(3, sliderInput("width", value=1000, min=100, max=10e3, step=10,
                label="River Width [m]")),
        column(3, sliderInput("ub", value=2, min=0.1, max=5.0, step=0.01,
                label="Vessel Speed [m/s]")),
        column(3, sliderInput("heading", value=0.0, min=-89.0, max=89.0, step=0.1,
                label="Vessel Heading [deg]"))),
    fluidRow(plotOutput("plot", height="300")))

# Server Functions
server <- function(input, output, session)
{
    output$plot <- renderPlot({
        # convert from nautical "heading" (CW from North) to mathematical "theta" (CCW from east)
        # River speed (parabolic in y)
        ur <- function(y, width, max) {
            yy <- y / width
            ifelse(yy < 1, 4 * max * yy * (1 - yy), 0)
        }
        # Dynamical function
        func <- function(t, y, parms)
        {
            X <- y[1] # extract eastward coordinate (with origin at southern red dot)
            Y <- y[2] # extract northward coordinate (with origin at southern red dot)
            u <- ur(Y, parms$width, parms$ur) + parms$ub * cos(parms$theta)
            v <- parms$ub * sin(parms$theta)
            list(c(u=u, v=v)) # return derivatives dX/dt and dY/dt
        }
        # set up parameters
        parms <- list(
            width=input$width,
            ur=input$ur,
            ub=input$ub,
            theta=heading2theta(input$heading))
        # Set up initial conditions (i.e. initial location)
        IC <- c(0, 0)
        # Establish reporting times.
        tmax <- 50 * input$width/input$ub # guess on time required
        times <- seq(0, tmax, length.out=1000)
        # Solve the DE
        sol <- lsoda(IC, times, func, parms=parms)
        # Plot
        par(mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
        inwater <- sol[,3] <= 1.04*input$width
        sol <- sol[inwater,]
        plot(sol[, 2], sol[, 3], asp=1, type="l", lwd=2, ylim=c(-0.04*input$width, 1.04*input$width),
            yaxs="i", xlab="x [m]", ylab="y [m]", pch=20)
        grid()
        usr <- par("usr")
        polygon(c(usr[1], usr[1], usr[2], usr[2]), c(parms$width, usr[4], usr[4], parms$width), col="tan")
        polygon(c(usr[1], usr[1], usr[2], usr[2]), c(usr[3], 0, 0, usr[3]), col="tan")
        points(0, 0, col=2, pch=20, cex=2.5)
        points(0, input$width, col=2, pch=20, cex=2.5)
        end <- which(sol[,3] >= input$width)[1]
        if (length(end) > 0 && is.finite(end)) {
            tau <- sol[end, 1]
            mtext(sprintf("Reached north side in %s", timeFormat(tau)))
        }
    }, height=500, pointsize=18)

    # Accept keypress '?'
    observeEvent(input$keypressTrigger,
        {
            if (intToUtf8(input$keypress) == "?") {
                showNotification(HTML("<b>Many rivers to cross</b><br><b>But I can't seem to find my way over</b><br>-- <i>Jimmy Cliff 1969</i>"),
                type="message", duration=NULL)
            }
        })
}

shinyApp(ui=ui, server=server)
