#install.packages("RSelenium")
library(RSelenium)
library(rvest)
library(tidyr)

remDr <- remoteDriver(
  remoteServerAddr = "localhost",
  port = 4446L,
  browserName = "chrome"
)

remDr$open()

remDr$navigate("https://www.op.gg/")

# 통계 탭 클릭
webElems <- remDr$findElements(using = "css selector", "li")

resHeaders <- unlist(lapply(webElems, function(x) {x$getElementText()}))

webElem <- webElems[[which(resHeaders == '통계')]]

webElem$clickElement()

#필요한 페이지 소스 받아오기
page_parse = remDr$getPageSource()[[1]]

page_html = page_parse %>% read_html()

###데이터 정리###

# 테이블 자료 받아서 한국어로 인코딩 하기
Sys.setlocale('LC_ALL', 'English')
table = page_html %>% html_table(fill = TRUE)
Sys.setlocale('LC_ALL', 'Korean')

df = table[[2]]

# 열 이름 설정 후 필요없는 데이터 제거 
rownames(df) = df[, 1]

df = df[, c(-1,-2)]

# 승률에 '%' 제거 후 숫자로 변환
df[2] <- sapply(df[2], function(x) {
  str_replace_all(x, '%', '') %>%
    as.numeric()
})

# 플레이수, 골드에 ',' 제거 후 숫자로 변환
df[c(3,6)] <- sapply(df[c(3,6)], function(x) {
  str_replace_all(x, ',', '') %>%
    as.numeric()
})

# 평점에서 뒤 ':1' 제거 후 숫자로 변환
df[4] <- sapply(df[4], function(x) {
  str_replace_all(x, ':1', '') %>%
    as.numeric()
})

# 최종데이터
df

remDr$close() 

