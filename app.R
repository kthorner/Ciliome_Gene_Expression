source("installation.R")

library(shiny)
library(shinyWidgets)
library(DT)
library(readxl)
library(tidyxl)
library(magrittr)
library(ggplot2)

gene_meta <- read_excel("data/gene_table.xlsx",sheet = 1,col_names = c("Column","Description"))
gene_table <- read_excel("data/gene_table.xlsx",sheet = 2)
tpm_data <- read.table("data/tpm_data.txt",sep="\t",header = T)
gene_autocomplete <- gene_table$mouse_symbol
level_order <- c("Head","Limb","Trunk","Dorsal NT","Ventral NT","MNP","FNP","MXP","Limbs","Lung","Palate")

callback <- '
$("div.search").append($("#mySearch"));
$("#mySearch").on("keyup redraw", function(){
  var splits = $("#mySearch").val().split(",").filter(function(x){return x !=="";})
  var searchString = "(" + splits.join("|") + ")";
  table.columns(2).search(searchString, true).draw(true);
});
'

ui <- fluidPage(
  
	setBackgroundColor(
		color = c("#e9edff")
	),

	tags$head(tags$style(".dataTables_wrapper .dt-buttons {
		float:none; 
		text-align:center;}"
	)),

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
						p("Here, we provide access to our transcriptomics resources detailing tissue-specific ciliome heterogeneity in an easily searchable database."),
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
            		img(src = "abstract.jpg", height = 380, width = 340
            		)
            	)
            )
        ),
        tabPanel(
        	"About",
	    	wellPanel(
				p("Contact us:"),
				p("Samantha Brugmann, Samantha.Brugmann@cchmc.org"),
				p("Kevin Peterson, kevin.peterson@jax.org"),
				br(),
				p("Developed by Konrad Thorner"),
				p("For technical issues please see the ", a(href="https://github.com/kthorner/Ciliome_Gene_Expression", "GitHub page"))
			)
        ),
		tabPanel(
			"Help",
			wellPanel(
				h2("Database Instructions"),
				tags$ul(
					tags$li("Some columns are hidden by default. Additional columns can be viewed using the 'Column Visibility' dropdown."),
					tags$li("Results can be saved using the CSV and Excel buttons for further analysis."),
					tags$li("View genes of interest by entering one or more comma-separated genes in the 'Gene Search' box."),
					tags$li("For more advanced searches, use the filters at the top of each column. Regular expressions can also be applied."),
					tags$li("Search for multiple entries by separating with ' | '. Ex. CD4|CD8."),
					tags$li("Search for entries that start with a pattern using ' ^ '. Ex. ^A returns all entries starting with A.")
				)
			),
			wellPanel(
				h2("Database Legend"),
				tags$ul(
					tags$li(tags$b(colnames(gene_table)[1]),paste0(": ",gene_meta$Description[1])),
					tags$li(tags$b(colnames(gene_table)[2]),paste0(": ",gene_meta$Description[2])),
					tags$li(tags$b(colnames(gene_table)[3]),paste0(": ",gene_meta$Description[3])),
					tags$li(tags$b(colnames(gene_table)[4]),paste0(": ",gene_meta$Description[4])),
					tags$li(tags$b(colnames(gene_table)[5]),paste0(": ",gene_meta$Description[5])),
					tags$li(tags$b(colnames(gene_table)[6]),paste0(": ",gene_meta$Description[6])),
					tags$li(tags$b(colnames(gene_table)[7]),paste0(": ",gene_meta$Description[7])),
					tags$li(tags$b(colnames(gene_table)[8]),paste0(": ",gene_meta$Description[8])),
					tags$li(tags$b(colnames(gene_table)[9]),paste0(": ",gene_meta$Description[9])),
					tags$li(tags$b(colnames(gene_table)[10]),paste0(": ",gene_meta$Description[10])),
					tags$li(tags$b(colnames(gene_table)[11]),paste0(": ",gene_meta$Description[11])),
					tags$li(tags$b(colnames(gene_table)[12]),paste0(": ",gene_meta$Description[12])),
					tags$li(tags$b(colnames(gene_table)[13]),paste0(": ",gene_meta$Description[13])),
					tags$li(tags$b(colnames(gene_table)[14]),paste0(": ",gene_meta$Description[14])),
					tags$li(tags$b(colnames(gene_table)[15]),paste0(": ",gene_meta$Description[15])),
					tags$li(tags$b(colnames(gene_table)[16]),paste0(": ",gene_meta$Description[16])),
					tags$li(tags$b(colnames(gene_table)[17]),paste0(": ",gene_meta$Description[17])),
					tags$li(tags$b(colnames(gene_table)[18]),paste0(": ",gene_meta$Description[18])),
					tags$li(tags$b(colnames(gene_table)[19]),paste0(": ",gene_meta$Description[19])),
					tags$li(tags$b(colnames(gene_table)[20]),paste0(": ",gene_meta$Description[20])),
					tags$li(tags$b(colnames(gene_table)[21]),paste0(": ",gene_meta$Description[21])),
					tags$li(tags$b(colnames(gene_table)[22]),paste0(": ",gene_meta$Description[22])),
					tags$li(tags$b(colnames(gene_table)[23]),paste0(": ",gene_meta$Description[23]))
				)
			)
		),
		tabPanel(
			"Database",
			tags$input(type = "text", id = "mySearch", placeholder = "Gene Search"),
			DT::dataTableOutput("dt_1")
		),
		tabPanel("Expression",
			wellPanel(
			  selectizeInput(
			    inputId = 'gene_search',
			    label = 'Gene Search',
			    choices = gene_autocomplete,
			    selected = NULL,
			    multiple = FALSE,
			    options = list(create = FALSE)
			  )
			),
			wellPanel(
				plotOutput("violin_plot")
			)
		)	
	)  
)

server <- function(input, output) {
	output$dt_1 <- DT::renderDataTable({DT::datatable(
		gene_table,
		filter = "top",
		extensions = c('Buttons'),
		callback=JS(callback),
		options = list(
		columnDefs = list(list(
    	targets = c(3:11,13,17,19,20,21,23), visible = FALSE)),
    	dom = "<'row'<'col-sm-3'l><'col-sm-6'B><'col-sm-3'<'search'>>><'row'<'col-sm-12'tr>><'row'<'col-sm-5'i><'col-sm-7'p>>",
		buttons = c('colvis','csv','excel'),
		search = list(regex = TRUE)
		))}, server = FALSE)

	output$violin_plot <- renderPlot({ 
		gene_search <- input$gene_search
		tpm_gene <- tpm_data[tpm_data$Gene == gene_search,]
		ggplot(tpm_gene, aes(x= factor(Tissue, level=level_order), y=value, color=Time)) + geom_violin() + xlab("\nTissue") + ylab("Expression\n") + theme_bw() + theme(axis.text=element_text(size=16),axis.title=element_text(size=18),plot.title = element_text(size=20)) + ggtitle(paste0(gene_search," expression")) + geom_jitter(shape=16, position=position_jitter(0.2))
		})
}

shinyApp(ui = ui, server = server)