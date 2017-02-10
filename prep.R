if (!require("data.table")) install.packages("data.table")
if (!require("stringi")) install.packages("stringi")
library(stringi)
library(data.table)
dir.create("./data_pre",showWarnings=F)

dl<-dir("./data",pattern = "smi",all.files = T)

for(i in 1:length(dl)){

  tem<-readLines(paste0("./data/",dl[i]),skipNul = T,warn = F)
  if(length(tem)<50){next}
  if(identical(tem,character(0))){next}
  chk<-try(nchar(tem), silent = T)
  if(class(chk)=="try-error"){next}
  tem<-gsub("Sync","SYNC",tem)
  tem<-gsub("sync","SYNC",tem)
  tem<-tem[grep("<SYNC",tem)[1]:grep("<SYNC",tem)[length(grep("<SYNC",tem))]]
  tem<-tem[-grep("<SYNC",tem)]
  tem<-gsub("font","FONT",tem)
  tem<-gsub("Font","FONT",tem)
  if(!identical(grep("<FONT",tem),integer(0))){
  tem<-tem[-grep("<FONT",tem)]}
  tem<-gsub("<br>","",tem)
  tem<-gsub("^- ","",tem)
  tem<-gsub("^(file|gopher|news|nntp|telnet|https?|ftps?|sftp):\\/\\/.*","",tem)
  tem<-tem[nchar(tem)>0]
  tem<-unlist(strsplit(tem,"/"))
  chk<-grep("^[ㄱ-ㅎ가-힣a-zA-Z0-9ㅏ-ㅣ\\.\\?!~ ]",tem)
  if(!identical(chk,1:length(tem))){
    tem<-tem[grepl("^[ㄱ-ㅎ가-힣a-zA-Z0-9ㅏ-ㅣ\\.\\?!~ ]",tem)]
  }
  tem<-gsub("[^ㄱ-ㅎ가-힣a-zA-Z0-9ㅏ-ㅣ\\.\\?!~ ]","",tem)
  tem<-stri_trim_both(tem)
  
  title<-dl[i]
  while(!identical(grep("\\.",strsplit(title,"")[[1]][1]),integer(0))){
    title<-gsub("^\\.","",title)
  }
  title<-gsub("\\.smi","",title)
  write.table(tem,paste0("./data_pre/",title,".txt"),row.names = F,col.names = F,quote = F)
  print(paste0(i, " / ",length(dl)))
}
