source("installation.R")

library(shiny)
library(shinyWidgets)
library(DT)
library(readxl)

table_1 <- read_excel("data/Supplemental File 1_Custom Ciliome 11.17.21.xlsx",skip=7)
table_2 <- read_excel("data/Supplemental File 2_Differentially Expressed Ciliome 1.19.22.manuallycurated.xlsx",skip=7)

table_3_tissue_limb <- read_excel("data/Supplemental File 3_DE ciliome by tissue.xlsx",skip=5,sheet=1,range="A6:G16")
table_3_tissue_neural <- read_excel("data/Supplemental File 3_DE ciliome by tissue.xlsx",skip=5,sheet=1,range="A18:G135")
table_3_tissue_face <- read_excel("data/Supplemental File 3_DE ciliome by tissue.xlsx",skip=5,sheet=1,range="A137:G184")
table_3_tissue_limb_face <- read_excel("data/Supplemental File 3_DE ciliome by tissue.xlsx",skip=5,sheet=1,range="A186:G220")
table_3_tissue_limb_neural <- read_excel("data/Supplemental File 3_DE ciliome by tissue.xlsx",skip=5,sheet=1,range="A222:G234")
table_3_tissue_neural_face <- read_excel("data/Supplemental File 3_DE ciliome by tissue.xlsx",skip=5,sheet=1,range="A236:G290")
table_3_tissue_all <- read_excel("data/Supplemental File 3_DE ciliome by tissue.xlsx",skip=5,sheet=1,range="A292:G298")

table_3_craniofacial_mxp <- read_excel("data/Supplemental File 3_DE ciliome by tissue.xlsx",skip=5,sheet=2,range="A6:G21")
table_3_craniofacial_mnp <- read_excel("data/Supplemental File 3_DE ciliome by tissue.xlsx",skip=5,sheet=2,range="A23:G31")
table_3_craniofacial_fnp <- read_excel("data/Supplemental File 3_DE ciliome by tissue.xlsx",skip=5,sheet=2,range="A33:G66")
table_3_craniofacial_mxp_mnp <- read_excel("data/Supplemental File 3_DE ciliome by tissue.xlsx",skip=5,sheet=2,range="A68:G76")
table_3_craniofacial_mxp_fnp <- read_excel("data/Supplemental File 3_DE ciliome by tissue.xlsx",skip=5,sheet=2,range="A78:G118")
table_3_craniofacial_fnp_mnp <- read_excel("data/Supplemental File 3_DE ciliome by tissue.xlsx",skip=5,sheet=2,range="A120:G133")
table_3_craniofacial_all <- read_excel("data/Supplemental File 3_DE ciliome by tissue.xlsx",skip=5,sheet=2,range="A135:G178")

table_3_neuroectodermal_dnt <- read_excel("data/Supplemental File 3_DE ciliome by tissue.xlsx",skip=5,sheet=3,range="A6:G49")
table_3_neuroectodermal_vnt <- read_excel("data/Supplemental File 3_DE ciliome by tissue.xlsx",skip=5,sheet=3,range="A51:G75")
table_3_neuroectodermal_dnt_vnt <- read_excel("data/Supplemental File 3_DE ciliome by tissue.xlsx",skip=5,sheet=3,range="A77:G206")

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
    					)
		    		)
		    	),
		    	column(4,
            		img(src = "ciliome_figure.jpg", height = 360, width = 300
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
				tabsetPanel(
					tabPanel("Limb",DT::dataTableOutput("dt_3t_limb")),
					tabPanel("Neural",DT::dataTableOutput("dt_3t_neural")),
					tabPanel("Face",DT::dataTableOutput("dt_3t_face")),
					tabPanel("Limb + Face",DT::dataTableOutput("dt_3t_limb_face")),
					tabPanel("Limb + Neural",DT::dataTableOutput("dt_3t_limb_neural")),
					tabPanel("Neural + Face",DT::dataTableOutput("dt_3t_neural_face")),
					tabPanel("All",DT::dataTableOutput("dt_3t_all"))
				)
			)
		),
		tabPanel("Craniofacial Specific Ciliomes",
			wellPanel(
				tabsetPanel(
					tabPanel("MXP",DT::dataTableOutput("dt_3c_mxp")),
					tabPanel("MNP",DT::dataTableOutput("dt_3c_mnp")),
					tabPanel("FNP",DT::dataTableOutput("dt_3c_fnp")),
					tabPanel("MXP + MNP",DT::dataTableOutput("dt_3c_mxp_mnp")),
					tabPanel("MXP + FNP",DT::dataTableOutput("dt_3c_mxp_fnp")),
					tabPanel("FNP + MNP",DT::dataTableOutput("dt_3c_fnp_mnp")),
					tabPanel("All",DT::dataTableOutput("dt_3c_all"))
				)
			)
		),
		tabPanel("Neuroectodermal Specific Ciliomes",
			wellPanel(
				tabsetPanel(
					tabPanel("DNT",DT::dataTableOutput("dt_3n_dnt")),
					tabPanel("VNT",DT::dataTableOutput("dt_3n_vnt")),
					tabPanel("DNT + VNT",DT::dataTableOutput("dt_3n_dnt_vnt"))
				)
			)
		),
		tabPanel("DE ciliary genes upregulated in mesenchymal clusters",
			wellPanel(
				DT::dataTableOutput("dt_4")
			)
		),
		tabPanel("DE ciliary genes upregulated in epithelial clusters",
			wellPanel(
				DT::dataTableOutput("dt_5")
			)
		),
		tabPanel("DE ciliary genes upregulated in both mesenchymal and epithelial clusters",
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
	output$dt_3t_limb <- DT::renderDataTable({DT::datatable(table_3_tissue_limb)})
	output$dt_3t_neural <- DT::renderDataTable({DT::datatable(table_3_tissue_neural)})
	output$dt_3t_face <- DT::renderDataTable({DT::datatable(table_3_tissue_face)})
	output$dt_3t_limb_face <- DT::renderDataTable({DT::datatable(table_3_tissue_limb_face)})
	output$dt_3t_limb_neural <- DT::renderDataTable({DT::datatable(table_3_tissue_limb_neural)})
	output$dt_3t_neural_face <- DT::renderDataTable({DT::datatable(table_3_tissue_neural_face)})
	output$dt_3t_all <- DT::renderDataTable({DT::datatable(table_3_tissue_all)})
	output$dt_3c_mxp <- DT::renderDataTable({DT::datatable(table_3_craniofacial_mxp)})
	output$dt_3c_mnp <- DT::renderDataTable({DT::datatable(table_3_craniofacial_mnp)})
	output$dt_3c_fnp <- DT::renderDataTable({DT::datatable(table_3_craniofacial_fnp)})
	output$dt_3c_mxp_mnp <- DT::renderDataTable({DT::datatable(table_3_craniofacial_mxp_mnp)})
	output$dt_3c_mxp_fnp <- DT::renderDataTable({DT::datatable(table_3_craniofacial_mxp_fnp)})
	output$dt_3c_fnp_mnp <- DT::renderDataTable({DT::datatable(table_3_craniofacial_fnp_mnp)})
	output$dt_3c_all <- DT::renderDataTable({DT::datatable(table_3_craniofacial_all)})
	output$dt_3n_dnt <- DT::renderDataTable({DT::datatable(table_3_neuroectodermal_dnt)})
	output$dt_3n_vnt <- DT::renderDataTable({DT::datatable(table_3_neuroectodermal_vnt)})
	output$dt_3n_dnt_vnt <- DT::renderDataTable({DT::datatable(table_3_neuroectodermal_dnt_vnt)})
	output$dt_4 <- DT::renderDataTable({DT::datatable(table_4)})
	output$dt_5 <- DT::renderDataTable({DT::datatable(table_5)})
	output$dt_6 <- DT::renderDataTable({DT::datatable(table_6)})
	output$dt_7 <- DT::renderDataTable({DT::datatable(table_7)})
}

shinyApp(ui = ui, server = server)