# scLAPA
Learning association for single-cell transcriptomics by integrating single-cell profiling of gene expression and alternative polyadenylation
# Introduction
High variability and dropout rate inherent in scRNA-seq confounds the reliable quantification of cell-cell associations based on the gene expression profile alone. Lately bioinformatics studies have emerged to capture key transcriptome information on alternative polyadenylation (APA) from standard scRNA-seq and revealed APA dynamics among cell types, suggesting the possibility of discerning cell identities with the APA profile.  We proposed a toolkit called scLAPA for learning association for single-cell transcriptomics by combing single-cell profiling of gene expression and alternative polyadenylation. As a comprehensive toolkit, scLAPA provides a unique strategy to learn cell-cell associations, improve cell type clustering and discover novel cell types by the augmentation of gene expression profiles with polyadenylation information, which can be incorporated in most existing scRNA-seq pipelines.

scLAPA mainly consists of four modules (Figure S1): (i) the input module, (ii) cell-cell distance, (iii) distance fusion, (iv) cell type clustering. The input module prepares the input for scLAPA, including a poly(A) site expression matrix (hereinafter referred as PA-matrix) and a gene expression matrix (hereinafter referred as GE-matrix).  In the module of cell-cell distance, a cell-cell distance matrix is learned for PA-matrix (called PA-dist) and GE-matrix (called GE-dist), respectively. The module of distance fusion employs similarity network fusion (SNF)  to integrate the two distance matrices (PA-dist and GE-dist) into one cell-cell distance matrix. The cell type clustering module clusters cells based on the fused distance matrix with various clustering methods.

![image](https://github.com/BMILAB/scLAPA/blob/main/img/scLAPA_pipeline.png)

# Installing scLAPA
## Mandatory
•	R (>3.4). R [3.5.3](https://www.r-project.org/) is recommended.
## R packages
Please install the following R packages:
`SIMLR SNFtool stats igraph flashClust dplyr propr psych clues flashClust`
## Data
Gene expression matrix of five main datasets used in this study:  
Mouse Hypothalamus ([GSE87544](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE87544))  
Mouse Medial amygdala ([GSE124061](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE124061))  
Mouse Mammary epithelial cells ([GSE106273](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE106273))  
Arabidopsis roots ([GSE123013](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE123013))  
Human Peripheral blood mononuclear cells ([10x Genomics website](https://www.10xgenomics.com/))  
The identified poly(A) sites of all data stored in Rdata files can be downloaded [here](http://www.bmibig.cn/mnt/scLAPA).
## installing
```
install.packages("devtools")  
library(devtools)  
install_github("BMILAB/scLAPA")  
library(scLAPA)  
```
# Application examples
In order to facilitate user understanding, we use the provided example  [Hypothalamus](https://www.sciencedirect.com/science/article/pii/S2211124717303212?via%3Dihub) to illustrate the standard analysis work-flow of scLAPA. Please refer to the [User Guide](https://github.com/BMILAB/scLAPA/blob/main/docs/scLAPA%20user%20guide.pdf) for full details.
## Citation
If you are using scLAPA, please cite: Guoli Ji, Wujing Xuan, Yibo Zhuang, Lishan Ye, Sheng Zhu, Wenbin Ye, Xi Wang, Xiaohui Wu*: Learning association for single-cell transcriptomics by integrating single-cell profiling of gene expression and alternative polyadenylation.
