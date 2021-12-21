# custom_scriptutils

## 1. create_GQ_readset.R

```
 module load mugqic/R_Bioconductor/4.1.0_3.13
 find -L raw_reads -name "*R1*gz" > list_of_readset
 Rscript create_GQ_readset.R  COVID_SURVEILLANCE_VARIANTS_GQ-8_NextSeqReadSet_2021-12-21_90.csv  readset.txt
 less -S  readset.txt
 ```
> Note: Make sure that the sample name and library name are different
