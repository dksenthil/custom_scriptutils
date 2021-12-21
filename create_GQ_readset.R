# script to get readset_file: @senthil
# assume the COntrols have the keywords ("Pos","Neg)
closeAllConnections()
rm(list = ls())
args = commandArgs(trailingOnly = TRUE)

#rgs[1] <- c("COVID_SURVEILLANCE_VARIANTS_GQ-6_NovaSeqReadSet_2021-09-13.csv")
#args[2] <- c("readset.txt")

list_of_fasta <- as.data.frame(read.table(file = "list_of_readset", header = F))
list_of_fasta$R1 <- sort(list_of_fasta$V1)
list_of_fasta$R2 <- gsub("_R1", "_R2", list_of_fasta$R1)
GQ_csv <- read.table(file = args[1],
                     header =  TRUE,
                     sep = ",",stringsAsFactors = FALSE)


GQ_csv <- GQ_csv[order(GQ_csv$ProcessingSheetId),]


out_csv <-
  setNames(
    data.frame(matrix(
      ncol = 13, nrow = nrow(GQ_csv)
    )),
    c(
      "Sample",
      "Readset",
      "Library",
      "RunType",
      "Run",
      "Lane",
      "Adapter1",
      "Adapter2",
      "QualityOffset",
      "BED",
      "FASTQ1",
      "FASTQ2",
      "BAM"
    )
  )
for (x in 1:nrow(GQ_csv)) {
  # Sample <- GQ_csv$Name[x]
  if (grepl("Pos|Neg", GQ_csv$Name[x], ignore.case = TRUE)) {
    out_csv$Sample[x] <- GQ_csv$ProcessingSheetId[x]
  } else{
    out_csv$Sample[x] <- GQ_csv$Name[x]
  }
  
  out_csv$Readset[x] <- GQ_csv$Library.Name[x]
  out_csv$Library[x] <- GQ_csv$Library.Name[x]
  out_csv$RunType[x] <- GQ_csv$Run.Type[x]
  out_csv$Run[x] <- GQ_csv$Run[x]
  out_csv$Lane[x] <- GQ_csv$Region[x]
  out_csv$Adapter1[x] <-
    GQ_csv$Adaptor.Read.1..NOTE..Usage.is.bound.by.Illumina.Disclaimer.found.on.Nanuq.Project.Page.[x]
  out_csv$Adapter2[x] <-
    GQ_csv$Adaptor.Read.2..NOTE..Usage.is.bound.by.Illumina.Disclaimer.found.on.Nanuq.Project.Page.[x]
  out_csv$QualityOffset[x] <- GQ_csv$Quality.Offset[x]
  out_csv$BED[x] <- c("")
  #BED <- GQ_csv$BED.Files
  out_csv$FASTQ1[x] <-
    list_of_fasta$R1[grepl(GQ_csv$ProcessingSheetId[x], list_of_fasta$R1)]
  out_csv$FASTQ2[x] <-
    list_of_fasta$R2[grepl(GQ_csv$ProcessingSheetId[x], list_of_fasta$R2)]
  out_csv$BAM[x] <- c("")
  
}

write.table(
  out_csv,
  args[2],
  quote = F,
  row.names = F,
  col.names = T,
  sep = "\t"
)
