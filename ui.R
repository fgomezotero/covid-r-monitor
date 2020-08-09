library(shiny)
library(shinydashboard)
library(plotly)

status1 <- "primary"
status2 <- "info"

shinyUI(

    dashboardPage(
      dashboardHeader(title = "COVID R Monitor"),

      dashboardSidebar(collapsed=FALSE,

          sidebarMenu(
              menuItem("Uruguay", tabName = "uruguay", icon = icon("dashboard")),
              menuItem("Comparativas", tabName = "comparativas", icon = icon("dashboard")),
              menuItem("Parámetros de Estimación",
                      sliderInput("window_R", "Ventana estimacion R", 1, 14, 7, step = 1),
                      sliderInput("window_ma", "Ventana suavizado", 2, 14, 7, step = 1),

                      numericInput("mean_covid_si", "Media SI", 3.95, min = 0, max = 15, step = 0.2),
                      numericInput("sd_covid_si", "Desvio SI", 4.75, min = 0, max = 15, step = 0.25)
                    )
          )
      ),

      dashboardBody(

          tabItems(
              tabItem(tabName = "uruguay",

                    fluidRow(
                      infoBoxOutput("uruguay"),
                      infoBoxOutput("uruguay_ci_lower"),
                      infoBoxOutput("uruguay_ci_upper")
                    ),
                    fluidRow(
                      box(title = "Casos registrados", plotlyOutput("plot_incidence", height = 300),status="primary",solidHeader = TRUE,
                collapsible = TRUE),
                      box(title = "Estimacion de tasa R",plotlyOutput("plot_estimR", height = 300),status="primary",solidHeader = TRUE,
                collapsible = TRUE)
                    ),
                    fluidRow(
                      box(title = "Sobre la estimacion:", HTML("<strong>Metodologia: </strong> Documento realizado por E. Mordecki explicando la metodologia : <a href='http://www.cmat.edu.uy/~mordecki/EpiEstim_reporte.pdf'>Reporte</a>.<br />"),HTML("<strong>Origen de los datos:</strong> Los datos de Uruguay y otros países son extraídos de <a href='https://ourworldindata.org/coronavirus-source-data'>ourworldindata</a>. Esto puede presentar discrepanacias con datos oficiales de cada pais."),status="primary",solidHeader = TRUE,
                collapsible = TRUE),
                      box(title = "Descargar los resultados", downloadLink("downloadData", "Resultados de estimacion"),status="primary",solidHeader = TRUE,
                collapsible = TRUE)
                    ),
                ),
                tabItem(tabName="comparativas",
                    fluidRow(
                      box(title= "Elegir Pais 1:", uiOutput("choose_country_1"),status=status1,solidHeader = TRUE,
                      collapsible = TRUE),
                      box(title= "Elegir Pais 2:", uiOutput("choose_country_2"),status=status2,solidHeader = TRUE,
                      collapsible = TRUE)
                    ),
                    fluidRow(
                      box(title = "Casos registrados", plotlyOutput("plot_incidence_country_1", height = 300),status=status1,solidHeader = TRUE,
                      collapsible = TRUE),
                      box(title = "Casos registrados", plotlyOutput("plot_incidence_country_2", height = 300),status=status2,solidHeader = TRUE,
                      collapsible = TRUE)
                    ),
                    fluidRow(
                      box(title = "Estimacion de tasa R",plotlyOutput("plot_estimR_country_1", height = 300),status=status1,solidHeader = TRUE,
                      collapsible = TRUE),
                      box(title = "Estimacion de tasa R",plotlyOutput("plot_estimR_country_2", height = 300),status=status2,solidHeader = TRUE,
                      collapsible = TRUE)
                    ),
                )
            ),

        tags$footer(HTML("Desarrollado por Andres Ferragut (Univ. ORT Uruguay) y Ernesto Mordecki (CMAT, UdelaR) en base a la biblioteca EpiEstim. Contacto: <a href='mailto:ferragut@ort.edu.uy'>ferragut@ort.edu.uy</a>. <a href='https://github.com/aferragu/covid-r-monitor'>Codigo</a>"))
      )
    )
)