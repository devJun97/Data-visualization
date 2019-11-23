
# 날짜를 클랜징 해주는 함수
library(lubridate) 
# 크롤링에 필요한 패키지
library(httr)
library(rvest)

#symbol에 따라 회사를 다르게 설정
symbol <- '222810' 
  #ex) 000660 sk 하이닉스 symbol

url <- paste0('https://fchart.stock.naver.com/sise.nhn?symbol=',symbol,'&timeframe=day&count=500&requestType=0')

data <- GET(url) %>% 
  read_html %>% 
  html_nodes('item') %>% 
  html_attr('data') %>% 
  strsplit("\\|")

data = lapply(data, function(x) {
  x[c(1:6)] %>% t() %>% data.frame()
})
data = do.call(rbind, data)

str(data)

for(i in 2:length(data)){
  data[,i] = as.numeric(as.character(data[,i]))
}

# 날짜별 행 이름 변경
rownames(data) = ymd(data[,1]) %>% as.character
data[,1] = NULL

# 열 이름 변경
cname <- c('시가','고가','저가','종가','거래량')
colnames(data) <-  cname

# 최종 데이터 프레임 
data