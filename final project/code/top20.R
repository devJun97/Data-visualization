############### 네이버 실시간 검색어 TOP 20 데이터 저장 ######################

library(RSelenium)
library(rvest)
library(tidyr)
require(lubridate)

remDr <- remoteDriver(
  remoteServerAddr = "localhost",
  port = 4446L,
  browserName = "chrome"
)

remDr$open()

remDr$navigate("https://datalab.naver.com/")

webElems <- remDr$findElements(using = "css selector", "li")
resHeaders <- unlist(lapply(webElems, function(x) {x$getElementText()}))
webElem <- webElems[[which(resHeaders == '급상승검색어')]]
webElem$clickElement()

webElem_level <- remDr$findElement(using = "xpath", value ='//*[@id="content"]/div/div[2]/div[2]/div[1]/div[1]/div/div/ul/li[1]/div/div/a[1]' )
webElem_level$clickElement()

# 텍스트 불러오기 
webElem1 <- remDr$findElement(using = 'xpath', value = '//*[@id="content"]/div/div[2]/div[2]/div[2]')
data <- unlist(webElem1$getElementText())
index <- gregexpr('\n', data)[[1]]
word = c()

# 텍스트 데이터 전처리
for(i in 1:(length(index)/2)){
  word[i] <- substr(data, index[2*i-1]+1, index[2*i]-1)
}
word[20] <- substr(data, index[length(index)]+1, nchar(data)) #20번째단어는 수동으로 지정

word <- matrix(word)
colnames(word) <- '검색어'
  
# URL 폴더에 저장
folder <- 'c:/search'
if(!dir.exists(folder)) dir.create(folder)
   
   # working directory 변경
   setwd(folder)
   
   # 오늘 날짜
   date <- Sys.Date()
   
   # 현재 시간
   h <- hour(Sys.time())
   m <- minute(Sys.time())
  
   # 저장할 파일 이름 생성
   folder.name <- paste0( date," " ,h ,"시")
   now.folder <- paste(folder, folder.name, sep='/')
   
   # 폴더 생성   
   if(!dir.exists(now.folder)) dir.create(now.folder)
   
   setwd(now.folder)   
   
   file <- word
   file.name <- paste0(h,'-',m,'.csv')
   
   # 웹 사이트에서 가져온 자료 파일로 저장
   write.csv(file, file = file.name, row.names = F)
   
   remDr$close()
   