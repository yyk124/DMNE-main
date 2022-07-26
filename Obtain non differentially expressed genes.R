install.packages("openxlsx")
library(openxlsx)
counts <- read.csv("D:\\tian\\Desktop\\PAAD\\13270\\13270_reorder.csv",
                   header = T,row.names = 1)
if (!requireNamespace("BiocManager", quietly=TRUE))
  install.packages("BiocManager")
BiocManager::install("TCGAbiolinks")
install.packages("TCGAbiolinks")
library(TCGAbiolinks)
query <- GDCquery(project = "TCGA-PAAD",
                  data.category = "Transcriptome Profiling",
                  data.type = "Gene Expression Quantification",
                  workflow.type = "HTSeq - Counts")
samplesDown <- getResults(query,cols=c("cases"))
dataSmTP <- TCGAquery_SampleTypes(barcode = samplesDown, typesample = "TP")
dataSmNT <- TCGAquery_SampleTypes(barcode = samplesDown, typesample = "NT")
Counts <- counts
BiocManager::install("edgeR")
BiocManager::install("limma")
library("edgeR")
group <- c(rep(1,4),rep(2,174))
y <- DGEList(counts=Counts,group=group)  
keep <- filterByExpr(y)
y <- y[keep, , keep.lib.sizes=FALSE]
y <- calcNormFactors(y)
y <- estimateDisp(y)
et <- exactTest(y)
et <- topTags(et, n=100000)
et <- as.data.frame(et)
et <- cbind(rownames(et),et)
colnames(et) <- c("gene_id","log2FoldChange","log2CPM","PValue","FDR")
write.csv(et,file = "D:\\tian\\Desktop\\PAAD\\PAAD_DEG1.xls")
etsig <- et[which(et$PValue < 0.1 & abs(et$log2FoldChange) > 1),]
etsig[which(etsig$log2FoldChange > 0), "up_down"] <-"UP"
etsig[which(etsig$log2FoldChange < 0), "up_down"] <-"Down"
write.csv(etsig,file = "D:\\tian\\Desktop\\PAAD\\PAAD_DEG.xls")

