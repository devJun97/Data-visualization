# 네이버 급상승 검색어 TOP 20 
네이버 급상승 검색어를 수집하여 데이터를 만듭니다.

## 수집할 데이터
![캡처](https://user-images.githubusercontent.com/57973123/70846463-ccec6f80-1e9c-11ea-954b-5008c9cada84.PNG)

네이버는 국내 최고 검색 사이트 입니다.
따라서 매 분마다 검색어 순위가 바뀌는 사이트 입니다.
그래서 이 사이트에서 변동하는 검색어 기록을 활용하여 그날 하루의 가장 영향력있는 검색어를 찾아보았습니다.

## 수집한 데이터가 유용하다고 생각하는 이유

우리는 매일 변화하는 일상을 살아가고 있습니다. 인터넷 시대에 맞게 이슈가 생기면 사람들은 이슈를 검색해 봅니다. 
따라서 검색어를 수집하여 분석한다면 대중들이 관심있어하는 이슈를 도출해 낼 수 있기 때문입니다.

## 데이터
[데이터](https://github.com/ljhljh6552/Data-visualization/tree/master/final%20project/data) 수집기간 : 19-12-14 17시 ~ 19-12-14 20시 25분 (총 3시간 25분)

가져온 정보 : 네이버 실시가 검색어 TOP 20 

[데이터 병합 방법](https://github.com/ljhljh6552/Data-visualization/blob/master/final%20project/data/CSV%ED%8C%8C%EC%9D%BC%20%ED%95%A9%EC%B9%98%EA%B8%B0.md) 

[합쳐진 데이터](https://github.com/ljhljh6552/Data-visualization/blob/master/final%20project/data/merge.csv)

***데이터가 텍스트 타입, 따라서 텍스트 마이닝을 실시한다***

## [분석방법](https://github.com/ljhljh6552/Data-visualization/blob/master/final%20project/code/top20.R)과 결과

[**그래프코드**](https://github.com/ljhljh6552/Data-visualization/blob/master/final%20project/code/graph.R)

### - 막대그래프로 빈도분석

![Rplot](https://user-images.githubusercontent.com/57973123/70855385-66ec0080-1f0d-11ea-8b6e-82e60b585ef6.png)


### - WordCloud 그림

![1](https://user-images.githubusercontent.com/57973123/70855399-8d11a080-1f0d-11ea-813b-036ea319873c.png)

### - 빈도수 상관관계 그림

![Rplot1](https://user-images.githubusercontent.com/57973123/70855404-a74b7e80-1f0d-11ea-992e-f4bd30d6ca03.png)

## 결론

데이터를 수집한 기간동안 가장 핫한 topic은 '상주 영천 고속도로' 검색어로 당일 사고로 인하여 검색률이 급증했다는 것을 알 수 있다.

또한 '로드 fc'경기가 있었고, 넥플릭스에서 방영하는 '6언더그라운드'라는 드라마가 주목을 받았다고 할 수 있다.
