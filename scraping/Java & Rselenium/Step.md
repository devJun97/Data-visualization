# 1. Download 사이트
* selenium : https://selenium-release.storage.googleapis.com/index.html?path=3.9/
* geckodriver : https://github.com/mozilla/geckodriver/releases/tag/v0.17.0
* chromeDriver : https://sites.google.com/a/chromium.org/chromedriver/downloads

# 2. 실행순서
* cmd를 이용하여 위에서 다운 받은 파일들이 모여 있는 파일을 기본경로로 설정해준다.
* java -Dwebdriver.gecko.driver="geckodriver.exe" -jar selenium-server-standalone-3.9.1.jar -port 4446 실행
