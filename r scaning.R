# 날짜를 클랜징 해주는 함수
library(lubridate) 

# 크롤링에 필요한 패키지
library(httr)
library(rvest)

# 코스피 마지막 페이지 숫자로 나타내기
surl <- paste0('https://finance.naver.com/sise/sise_market_sum.nhn?sosok=0&page=1')

final = read_html(surl, encoding = "EUC-KR") %>%
  html_nodes(".pgRR") %>%
  html_nodes("a") %>%
  html_attr("href") %>%
  strsplit("=") %>%
  unlist() %>%
  tail(1) %>%
  as.numeric()

# 전 코스페이지에서 6자리 symbol가져오기
sym <- list()
for(j in 1:final){
  surl <- paste0('https://finance.naver.com/sise/sise_market_sum.nhn?sosok=0&page=',j)
  s_html <- GET(surl)
  
  symb <-  read_html(s_html, encoding = "EUC-KR") %>%
    html_nodes("tbody") %>%
    html_nodes("td") %>%
    html_nodes("a") %>%
    html_attr("href")
  
  symb <- sapply(symb, function(x) {
    substr(x, nchar(x) - 5, nchar(x))  #끝 6자리 숫자만 가져오기
  }) %>% unique()  #중복제거 
  
  
  sym[[j]] <- symb
}

sym <- unlist(sym)  #최종 symbol데이터 

final.data <- list()  # 최종 데이터 리스트로 지정
comname <- list()  # 회사이름을 리스트로 저장

for (i in 1:length(sym)){
#for(i in 1:5){  #데이터가 너무 많으므로 예제 데이터
  symbol <- sym[i]
  #symbol <- sym[2]
  url <- paste0('https://fchart.stock.naver.com/sise.nhn?symbol=',symbol,'&timeframe=day&count=500&requestType=0')
  
  
  #회사이름 가져오기
  company <- read_html(url, encoding = "EUC-KR") %>%  
    html_nodes('chartdata') %>%
    html_attr('name')
  
  #회사의 데이터 가져오기
  data <-
    read_html(url) %>% 
    html_nodes('item') %>% 
    html_attr('data') %>% 
    strsplit("\\|")
  
  data = lapply(data, function(x) {
    x[c(1:6)] %>% t() %>% data.frame()
  })
  
  data = do.call(rbind, data)
  
  # numeric으로 데이터 변환
  for(j in 2:length(data)){
    data[,j] = as.numeric(as.character(data[,j]))
  }
  
  # 날짜별 행 이름 변경
  rownames(data) = ymd(data[,1]) %>% as.character
  data[,1] = NULL
  
  # 열 이름 변경
  cname <- c('시가','고가','저가','종가','거래량')
  colnames(data) <-  cname
  
  final.data[[i]] <- data
  comname[[i]] <- company
}

#각 리스트에 회사명 추가
comname <- unlist(comname)

names(final.data) <- c(comname) 

#최종 데이터 리스트
final.data
