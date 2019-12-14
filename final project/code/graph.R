# cmd를 이용하여 csv합치기
a <- read.csv('merge.csv', header = T)

# 검색어 삭제
a <- a[!(a == '검색어'),]

##막대그래프
#install.packages("ggplot2")
library(ggplot2)
a.1 <- table(a)
a.3 <- data.frame(a.1)
p <- ggplot(data=a.3, aes(x=reorder(a, Freq), y=Freq)) + geom_bar(stat='identity') + coord_flip()
p + labs(x = '검색어', y = '빈도')


##wordcloud
#install.packages("wordcloud")
library(wordcloud)
windows(width=4, height=4); par(mar=c(2,2,2,2))
wordcloud(words=names(a.1), freq=a.1, scale=c(5,0.5), 
          min.freq=1, colors=rainbow(10), random.color=FALSE, random.order=FALSE, rot.per=0.25)

mg %>% as_tbl_graph() %>%
  ggraph() +
  geom_edge_link(aes(start_cap = label_rect(node1.name), end_cap = label_rect(node2.name))) +
  geom_node_text(aes(label=name))

##빈도수에 따른 의미연결망 
#install.packages('igraph')
library('igraph')

mg <- graph_from_data_frame(a.3)

plot(mg)
