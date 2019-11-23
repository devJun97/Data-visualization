# 삼성전자 연간 주요재무정보 
library(rvest)

url <- 'https://navercomp.wisereport.co.kr/v2/company/ajax/cF1001.aspx?cmp_cd=005930&fin_typ=0&freq_typ=Y&encparam=dEpwVmJWUFYrK2szNmtiWmo3UXMzQT09&id=ZlEwemUxRm'

# html에서 데이터 가져오기
html <- read_html(url)

table <- html %>% html_nodes("table")

table <- table[2]

td <- table %>% html_nodes('td')

text <- td %>% html_text()

# 열 이름 만들기
a1 <- html %>% html_nodes('tr')

a2 <- a1 %>% html_text()

a <- a2[38]

year <- gsub("(\r)(\n)(\t)*", "", a)

lyear <- year %>% strsplit('\\(IFRS연결)')

lyear <- unlist(lyear)

df <- as.data.frame(matrix(text,ncol=8, byrow=TRUE))

colnames(df) <- c(lyear)

# 행 이름 만들기
th1 <- html %>% html_nodes('tr')

title <-  html %>% html_nodes(' .title')

title <- title %>% html_text()

# 최종 데이터 프레임
data <- cbind(title,df)

data
