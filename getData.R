if (!require("rvest")) install.packages("rvest")
if (!require("stringi")) install.packages("stringi")
library(stringi)
library(rvest)
dir.create("./data",showWarnings=F)

url<-"http://gom.gomtv.com/main/index.html?ch=subtitles&pt=l&menu=subtitles"
tem<-read_html(url)
maxPage<-tem %>% html_nodes("div.pagenavi div a") %>% html_attr("onclick")
maxPage<-maxPage[length(maxPage)] %>% as.numeric

for(i in 520:maxPage){
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
    title<-stri_trim_both(gsub("[^a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣0-9.\\_ ]","",down[6]))
    title<-gsub(" ","_",title)
    
    var <- try(download.file(url,destfile = paste0("./data/",title)))
    if(is(var, "try-error")){
      Sys.sleep(1)
      print("sleep 1 sec.")
      next}
  }
  print(paste0(i," / ",maxPage))
}
