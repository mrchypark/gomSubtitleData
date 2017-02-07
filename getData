if (!require("rvest")) install.packages("rvest")
library(rvest)
dir.create("./data",warn=F)

url<-"http://gom.gomtv.com/main/index.html?ch=subtitles&pt=l&menu=subtitles"
tem<-read_html(url)
maxPage<-tem %>% html_nodes("div.pagenavi div a") %>% html_attr("onclick")
maxPage<-maxPage[length(maxPage)] %>% as.numeric

for(i in 1:maxPage){
url<-paste0("http://gom.gomtv.com/main/index.html?ch=subtitles&pt=l&menu=subtitles&lang=1&sWord=&page=",i)
tem<-read_html(url)
links<-tem %>% html_nodes("td.padd_left a") %>% html_attr("href")
links<-links[-c(1,2,3)]
  for(j in 1:length(links)){
    url<-paste0("http://gom.gomtv.com",links[j])
    tem<-read_html(url)
    down<-tem %>% html_nodes("div.download a") %>% html_attr("onclick")

    if(identical(down,character(0))){next}
    
    down<-strsplit(down,"'")[[1]]
    url<-paste0("http://gom.gomtv.com/main/index.html/?ch=subtitles&pt=down&intSeq=",down[2],"&capSeq=",down[4])
    download.file(url,destfile = paste0("./data/",down[6]))
  }
  print(paste0(i," / ",667))
}
