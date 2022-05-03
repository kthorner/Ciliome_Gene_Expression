source("installation.R")

library(shiny)
library(shinyWidgets)
library(DT)
library(readxl)
library(tidyxl)
library(magrittr)

gene_meta <- read_excel("data/gene_table.xlsx",sheet = 1,col_names = c("Column","Description"))
gene_table <- read_excel("data/gene_table.xlsx",sheet = 2)

ui <- fluidPage(
  
  setBackgroundColor(
    color = c("#e9edff")
  ),

	titlePanel("Ciliome Gene Expression Reference"),
	
	navlistPanel(
		widths=c(2,10),
		tabPanel(
			"Home",
			fluidRow(
				column(8,
					wellPanel(
						h2("Welcome!"),
						br(),
						p("Primary cilia are nearly ubiquitous organelles that transduce molecular and mechanical signals. While the basic structure of the cilium and the cadre of genes that contribute to ciliary formation and function (the ciliome) are believed to be evolutionarily conserved, the presentation of ciliopathies with narrow, tissue-specific phenotypes and specific molecular readouts suggests an unappreciated heterogeneity within this organelle."),
						br(),
						p("Herein, we consolidated three established ciliary databases: ", a(href="http://www.syscilia.org/goldstandard.shtml", "The Syscilia Gold Standard", .noWS = "outside"), ", ", a(href="https://tbb.bio.uu.nl/john/syscilia/ciliacarta/", "CiliaCarta", .noWS = "outside"), ", and ", a(href="http://cildb.i2bc.paris-saclay.fr", "Cildb", .noWS = "outside"), " [1,2] with two ciliogenesis modulator screens [3, 4] to generate a curated ciliome. Expression of genes that make up the ciliome was then profiled across various embryonic tissues and time points to test the hypothesis that the ciliome is heterogenous throughout development.", .noWS = c("after-begin", "before-end")),
						br(),
						p("Here, we provide access to our transcriptomics resources detailing tissues-specific ciliome heterogeneity in an easily searchable database."),
						br(),
						br(),
						tags$ol(
    						tags$li("Arnaiz, O., et al., Remodeling Cildb, a popular database for cilia and links for ciliopathies. Cilia, 2014. 3: p. 9."), 
    						tags$li("Arnaiz, O., et al., Cildb: a knowledgebase for centrosomes and cilia. Database (Oxford), 2009. 2009: p. bap022."), 
    						tags$li("Kim, J., et al., Functional genomic screen for modulators of ciliogenesis and cilium length. Nature, 2010. 464(7291): p. 1048-51."),
    						tags$li("Wheway, G., et al., An siRNA-based functional genomics screen for the identification of regulators of ciliogenesis and ciliopathy genes. Nat Cell Biol, 2015. 17(8): p. 1074-1087.")
    					),
    					br(),
    					br()
		    		)
		    	),
		    	column(4,
            		img(src = "ciliome_figure.jpg", height = 360, width = 300
            		)
            	)
            )
        ),
        tabPanel(
        	"About",
	    	wellPanel (
				p("Contact us:"),
				p("Samantha Brugmann, Samantha.Brugmann@cchmc.org")
			)
        ),
		tabPanel("Database",
			wellPanel(
				tags$ul(
					tags$li(gene_meta)
				)
			),
			wellPanel(
				DT::dataTableOutput("dt_1")
			)
		)
		
	)  
)

server <- function(input, output) {
	output$dt_1 <- DT::renderDataTable({DT::datatable(gene_table)})

shinyApp(ui = ui, server = server)