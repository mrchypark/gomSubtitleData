dl<-dir("./data_pre")

dac<-c()

for(i in 1:length(dl)){
  tem<-readLines(paste0("./data_pre/",dl[i]),encoding = "UTF-8")
  dac<-c(dac,tem)
  print(paste0(i, " / ",length(dl)))
}

write.table(dac[-length(dac)],paste0("./data.in"),row.names = F,col.names = F,quote = F,fileEncoding="UTF-8")
write.table(dac[-1],paste0("./data.out"),row.names = F,col.names = F,quote = F,fileEncoding="UTF-8")
