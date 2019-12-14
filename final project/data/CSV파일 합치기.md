# CSV파일 합치기
여러개로 쪼개진 csv 파일을 합쳐야 하는 경우가 있다.

물론 각 csv 파일을 열고 내용을 복사하고 붙이는 형식으로도 하나의 파일로 합칠 수 있다.

하지만 CMD 창에서 명령어를 이용하여 더 쉽고 편하게 파일을 합칠 수 있다.

합치고 싶은 파일을 한곳으로 모아준 후 명령 프롬프트 창에 
type *.csv > merge.csv 를 입력

결과적으로 merge.csv라는 파일 안에 모든 csv파일이 합쳐져 있는 것을 알수가 있다.


출처: https://lovedb.tistory.com/201 [More haste, less speed]
