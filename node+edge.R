if(!requireNamespace(BiocManager, quietly = TRUE))
  install.packages(BiocManager)
BiocManagerinstall(impute)
BiocManagerinstall(WGCNA)


library(WGCNA)
library(reshape2)
library(stringr)
library(readxl)
#TOM-read_excel('CUsersAdministratorDesktopdi4network.xlsx')
#TOM <-read.csv('D:\\MATBLE2017b\\bin\\cs\\average-GSE1326869control.csv',header=F)
TOM <-read.csv('D:\\MATBLE2017b\\bin\\cs\\average-GSE1326869control.csv',header=T,row.names = 1)
#,header=T,row.names = 1
#TOM <- data.frame(c(TOM[,15246]))
#rownames(TOM) <-TOM[,1] #Replace the row name with the first column of the data
#TOM <-TOM[-1]
#cyt1= exportNetworkToCytoscape(TOM,threshold = 0.,
#                               edgeFile=edge_TOM.txt,nodeFile=node_TOM.txt,
#                              weighted = TRUE);


#write.table(cyt1$edgeData,edge_TOM.csv,sep=t,quote=F)
#write.table(cyt1$nodeData,node_TOM.xlsx,sep=t,quote=F) 
cyt1= exportNetworkToCytoscape(TOM,threshold = 0.6,
                               edgeFile="edge_TOM.txt",nodeFile="node_TOM.txt",
                               weighted = TRUE);

table(duplicated(cyt1$edgeData$fromNode))
