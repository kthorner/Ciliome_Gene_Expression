source("installation.R")

library(shiny)
library(shinyWidgets)
library(DT)
library(readxl)

table_1 <- read_excel("data/Supplemental File 1_Custom Ciliome 11.17.21.xlsx",skip=7)
table_2 <- read_excel("data/Supplemental File 2_Differentially Expressed Ciliome 1.19.22.manuallycurated.xlsx",skip=7)
table_3 <- read_excel("data/Supplemental File 3_DE ciliome by tissue.xlsx",skip=5)
table_4 <- read_excel("data/Supplemental File 4_scRNAseq DE Ciliome in mesenchyme clusters.xlsx",skip=7)
table_5 <- read_excel("data/Supplemental File 5_scRNAseq DE Ciliome in Epithelia.xlsx",skip=7)
table_6 <- read_excel("data/Supplemental File 6_scRNAseq DE Ciliome in Epithelia and Mesenchyme.xlsx",skip=7)
table_7 <- read_excel("data/Supplemental File 7_scRNAseq Ciliary Genes with Expression Changes 12.6.21.xlsx",skip=6)

ui <- fluidPage(
  
  setBackgroundColor(
    color = c("#e9edff")
  ),

	titlePanel("Ciliome Gene Expression Reference"),
	
	navlistPanel(
		widths=c(2,10),
		tabPanel("Home",
			fluidRow(
				column(8,
					wellPanel(
						h2("Welcome!"),
						br(),
						p("Primary cilia are nearly ubiquitous organelles that transduce molecular and mechanical signals. While the basic structure of the cilium and the cadre of genes that contribute to ciliary formation and function (the ciliome) are believed to be evolutionarily conserved, the presentation of ciliopathies with narrow, tissue-specific phenotypes and specific molecular readouts suggests an unappreciated heterogeneity within this organelle."),
						br(),
						p("Here, we provide transcriptomics resources detailing tissues-specific ciliome heterogeneity. We identified a differentially expressed subgroup of genes within the ciliome that displayed tissue- and temporal- specificity. These genes were less conserved across species suggesting adaptations to organism and cell-specific function. Knocking out dynamically expressed ciliome genes detected during differentiation of multipotent neural crest cells into osteoblasts and associated with shifting the cilium from a chemosensory to mechanosensory role resulted in embryos with skeletal defects, supporting the conclusion that ciliome heterogeneity contributes to tissue- and cell-specific functions."),
						br(),
		    			tags$li("The ciliome varies significantly between different embryonic tissues"), 
		    			tags$li("The tissue-specific ciliome is comprised of low expressing, poorly conserved genes"), 
		    			tags$li("Differentiation of multipotent cells is accompanied by ciliome changes"),
		    			tags$li("Loss of osteogenic-specific ciliome genes result in skeletal phenotypes"),
		    		)
		    	),
		    	column(4,
            		img(src = "ciliome_figure.jpg", height = 400, width = 300
            		)
            	)
            )
        ),
		"Datasets",
		tabPanel("Curated Ciliome",
			wellPanel(
				DT::dataTableOutput("dt_1")
			)
		),
		tabPanel("Differentially Expressed Ciliome",
			wellPanel(
				DT::dataTableOutput("dt_2")
			)
		),
		tabPanel("Tissue Specific Ciliomes",
			wellPanel(
				DT::dataTableOutput("dt_3")
			)
		),
		tabPanel("DE ciliary genes upregulated in mesenchymal clusters ",
			wellPanel(
				DT::dataTableOutput("dt_4")
			)
		),
		tabPanel("DE ciliary gene upregulated in epithelial clusters ",
			wellPanel(
				DT::dataTableOutput("dt_5")
			)
		),
		tabPanel("DE ciliary gene upregulated in both mesenchymal and epithelial clusters ",
			wellPanel(
				DT::dataTableOutput("dt_6")
			)
		),
		tabPanel("Osteogenic Ciliome",
			wellPanel(
				DT::dataTableOutput("dt_7")
			)
		)
	)  
)

server <- function(input, output) {
	output$dt_1 <- DT::renderDataTable({DT::datatable(table_1)})
  	output$dt_2 <- DT::renderDataTable({DT::datatable(table_2)})
  	output$dt_3 <- DT::renderDataTable({DT::datatable(table_3)})
  	output$dt_4 <- DT::renderDataTable({DT::datatable(table_4)})
  	output$dt_5 <- DT::renderDataTable({DT::datatable(table_5)})
  	output$dt_6 <- DT::renderDataTable({DT::datatable(table_6)})
  	output$dt_7 <- DT::renderDataTable({DT::datatable(table_7)})

}

shinyApp(ui = ui, server = server)