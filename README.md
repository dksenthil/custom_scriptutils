# custom_scriptutils

## 1. create_GQ_readset.R

```
 module load mugqic/R_Bioconductor/4.1.0_3.13
 find -L raw_reads -name "*R1*gz" > list_of_readset
 Rscript create_GQ_readset.R  COVID_SURVEILLANCE_VARIANTS_GQ-8_NextSeqReadSet_2021-12-21_90.csv  readset.txt
 less -S  readset.txt
 ```
> Note: Make sure that the sample name and library name are different
```
# download paired-end RNA-seq data with 8 threads
parallel-fastq-dump --sra-id SRR17062757 --threads 8 --split-files --gzip
```

## Batch Download SRA
```
# tested on Linux and Mac. It may not work on Windows
>>> from bioinfokit.analys import fastq

# batch download fastq files
# make sure you have installed the latest version of NCBI SRA toolkit (version 2.10.8) and added binaries in the 
# system path
>>> fastq.sra_bd(file='sra_accessions.txt')

# increase number of threads
>>> fastq.sra_bd(file='sra_accessions.txt', t=16)

# use fasterq-dump customized options, you can see more options for fas terq-dump as
# fasterq-dump -help
fastq.sra_bd(file='sra_accessions.txt', t=16, other_opts='--outdir temp --skip-technical')

# multiple FASTQ (technical and biological)  files from from 
# 10x chromium single cell 3' RNA-seq data
# if you provide file containing SRA accessions for 10x chromium 
# single cell 3' RNA-seq data, it will give multiple FASTQ files
# for example, SRA accession SRR12564282 will give  three FASTQ files 
# (sample barcode,  cell barcode, and biological read FASTQ files)
fastq.sra_bd(file='path_to_sra_file', t=16, other_opts='--include-technical --split-files')
````
>Source: https://www.reneshbedre.com/blog/ncbi_sra_toolkit.html
