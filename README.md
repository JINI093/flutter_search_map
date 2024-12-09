# Flutter_기차 예매 프로그램

## 📖 목차
1. [프로젝트 소개]
2. [주요기능](#주요기능)
3. [개발기간](#개발기간)
4. [프로젝트 파일 구조](#프로젝트-파일-구조)
5. [Trouble Shooting](#trouble-shooting)
    
## 👨‍🏫 프로젝트 소개
내일배움캠프 Flutter_5기 Flutter숙련주차 개인 과제입니다.
네이버 검색 API를 사용하여 주소를 검색하고 좌표를 추출하여 지도에 표시하는 프로그램입니다.
<img alt="이미지 샘플" src="./assets/images/sample.png"/>

## 프로젝트 개요
기본 조건 (Basis)
----------------
- 프로젝트 명은 `flutter_search_map` 입니다.
- 검색어를 입력할 수 있는 초기 화면의 이름은 `HomePage` 로 합니다.
- 'home_page' 파일에서 검색어를 입력할 수 있는 텍스트 필드를 만들고 검색 버튼이 있습니다.
- 검색 버튼을 누르면 검색 결과를 보여주는 화면으로 이동합니다.
- 검색 결과는 리스트 형태로 보여지고, 이는 'home_list_view.dart' 파일에 있습니다.
- 검색 결과를 보여주는 화면의 이름은 `detail_page` 로 합니다.
- 데이터는 map.dart 파일에 있습니다.
- 데이터는 네이버 검색 API를 사용하여 가져옵니다.


앱 UI Flow
- 메인 화면에서 검색어를 입력하고 검색 버튼을 누릅니다.
- 입력 된 검색어로 네이버 검색 API를 호출하여 검색 결과를 가져옵니다.
- 검색 결과는 리스트뷰 형식으로 표시됩니다.
- 리스트뷰에서 각 검색 결과를 누르면 해당 페이지로 이동합니다.
- 검색창 우측의 버튼을 누르면 현재 지역의 좌표를 자동으로 추출하여 검색합니다.
    


## ⏲️ 개발기간
- 2024.12.03(월) ~ 2024.12.11(수)

### ✔️ Language
- dart


## 프로젝트 파일 구조
flutter_search_map/
├── lib/
│   ├── data/
│   │   ├── model/
│   │   │   └── map.dart                # Guidance 클래스 정의
│   │   └── repository/
│   │       └── map_repository.dart     # 네이버 및 VWORLD API 호출 로직
│   ├── ui/
│   │   ├── home/
│   │   │   ├── home_page.dart          # HomePage 위젯 정의
│   │   │   └── widgets/
│   │   │       ├── home_listview.dart  # 검색 결과 리스트뷰 위젯
│   │   │       ├── home_view_model.dart# HomePage 상태 관리 뷰모델
│   │   │       └── detail_page.dart    # 상세 페이지 위젯
│   ├── main.dart                       # 앱 진입점
├── ios/
│   └── Runner/
│       └── Info.plist                  # iOS 권한 설정
├── android/
│   └── app/
│       └── src/
│           └── main/
│               └── AndroidManifest.xml # Android 권한 설정
├── pubspec.yaml                        # 패키지 의존성 관리

## Trouble Shooting
- [ https://jin0629.tistory.com/32 [트러블 슈팅]Flutter 개인 프로젝트_네이버 지도 검색]
