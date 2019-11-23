# Visualiztion 
한류AI센터 역대 주가 알아보기

# 날짜를 클랜징 해주는 함수
library(lubridate) 

# 크롤링에 필요한 패키지
library(httr)

library(rvest)

# symbol에 따라 회사를 다르게 설정
symbol <- '222810' 
ex) 000660 sk 하이닉스 symbol     

# 여기서 사용하는 최종 URL
https://fchart.stock.naver.com/sise.nhn?symbol=222810&timeframe=day&count=500&requestType=0


# 한류AI센터 주가 불러오기
url <- paste0('https://fchart.stock.naver.com/sise.nhn?symbol=',symbol,'&timeframe=day&count=500&requestType=0')


data <- GET(url) %>% 
  read_html %>% 
  html_nodes('item') %>% 
  html_attr('data') %>% 
  strsplit("\\|")

# 나눈 데이터를 데이터 프레임으로 다시 묶어주기
data = lapply(data, function(x) {
  x[c(1:6)] %>% t() %>% data.frame()
}

data = do.call(rbind, data)

# data의 구조 알아보기
str(data)

# 2열부터 끝열까지 숫자로 변환
for(i in 2:lenght(data){
  data[,i] = as.numeric(as.character(data[,i]))
}

# 행을 문자열로 변환하고 행이름으로 설정
rownames(data) = ymd(data[,1]) %>% as.character
data[,1] = NULL

# 열 이름 변경
cname <- c('시가','고가','저가','종가','거래량')
colnames(data) <-  cname

# 최종 데이터 프레임 
data
