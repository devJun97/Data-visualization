############### ���̹� �ǽð� �˻��� TOP 20 ������ ���� ######################

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
webElem <- webElems[[which(resHeaders == '�޻�°˻���')]]
webElem$clickElement()

webElem_level <- remDr$findElement(using = "xpath", value ='//*[@id="content"]/div/div[2]/div[2]/div[1]/div[1]/div/div/ul/li[1]/div/div/a[1]' )
webElem_level$clickElement()

# �ؽ�Ʈ �ҷ����� 
webElem1 <- remDr$findElement(using = 'xpath', value = '//*[@id="content"]/div/div[2]/div[2]/div[2]')
data <- unlist(webElem1$getElementText())
index <- gregexpr('\n', data)[[1]]
word = c()

# �ؽ�Ʈ ������ ��ó��
for(i in 1:(length(index)/2)){
  word[i] <- substr(data, index[2*i-1]+1, index[2*i]-1)
}
word[20] <- substr(data, index[length(index)]+1, nchar(data)) #20��°�ܾ�� �������� ����

word <- matrix(word)
colnames(word) <- '�˻���'
  
# URL ������ ����
folder <- 'c:/search'
if(!dir.exists(folder)) dir.create(folder)
   
   # working directory ����
   setwd(folder)
   
   # ���� ��¥
   date <- Sys.Date()
   
   # ���� �ð�
   h <- hour(Sys.time())
   m <- minute(Sys.time())
  
   # ������ ���� �̸� ����
   folder.name <- paste0( date," " ,h ,"��")
   now.folder <- paste(folder, folder.name, sep='/')
   
   # ���� ����   
   if(!dir.exists(now.folder)) dir.create(now.folder)
   
   setwd(now.folder)   
   
   file <- word
   file.name <- paste0(h,'-',m,'.csv')
   
   # �� ����Ʈ���� ������ �ڷ� ���Ϸ� ����
   write.csv(file, file = file.name, row.names = F)
   
   remDr$close()
   