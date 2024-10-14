
# Instagram UX Clone

## Main View
![[Screenshot 2024-10-13 at 7.58.00 PM.png]]
- Scaffold 로 만들어진 home 화면은 AppBar,  Body 그리고 BottomNavigationBar로 구성되어 있음
- ThemeData 를 통해 app에 적용될 색상과 글꼴을 설정
- AppBar의 actions를 명령을 실행 할 수 있도록 함
    - AppBar에서 실행되는 명령들은 ...
    - actions를 추가된 아이콘은 오른쪽으로 정렬되어 추가 된다.
- BottomNavigationBar는 일종의 Tab을 통해 화면을 전환하는 효과를 가진다.
    - BottomNavigationBar의 각 item은 index 로 실별하며 onTap(index) gesture를 통해 이동한다.
    - 각 view 인덱스에 연동되는 enum 을 사용한다.
    - 현재 view의 인덱스는 GetX를 통하여 관리
- Body에 로딩되는 view는 BottomNavigationBar에서 선택된 것이다.


## Home View

![[Screenshot 2024-10-13 at 7.58.10 PM.png]]
- Home view 은 2개로 구성되어 있다. 좌우로 스크롤 되는 최근 활동이 있는 사용자 리스트와 상하로 스크롤 되는 feed 리스트로 구성되어 있다.
    - 좌우 스크롤은 SingleChildScrollView 를 scrollDirection: Axis.horizontal 와 Row() widget을 이용한다.
    - 상하 스크롤은 ListView.builder 를 사용한다.
        - **Feed 가 화면이 넘어가는 경우를 처리하기 위해 shrinkWrap: true, 와 physics: NeverScrollableScrollPhysics()**, 를 사용한다.
        - ListView.builder 는 itemBuilder를 사용하여 각 List Item를 생성한다.
- 사용자 리스트의 원은 Cotainer 의 radious 속성으로 만들었음
    - Conrainer widget의 width와 height를 같은 크기로 설정
    - `BoxDecoration`의 `borderRadius:BorderRadius.circular(40)`를 half 값으로 설정
  ```dart
Container(
width: 80,
height: 80,
padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
decoration: BoxDecoration(
color: RandomColor.getColorObject(Options(colorType: ColorType.orange, luminosity: Luminosity.light)),
borderRadius: BorderRadius.circular(40)),
)
  ```

- 각 Feed는 사용자 정보와 아이콘 버튼으로 구성된 상단 Bar, 이미지, feed에 대한 사용자 명령 bar 그리고 feed에 대한 사용자 입력 내용으로 구성
	-  좌우로 펼쳐져 있는 상단 Bar는 2개의 그룹으로 나눈다.
		- 2개의 그룹은 Row() widget 안에 있으며, 또 각각의 그룹은 다시 Row()로 구성한다. Row() child는 필요에 따라 Column 으로 구성할 수 있다.
		- Feed 상단 bar 뜯어 보기

		- ![[Screenshot 2024-10-13 at 8.36.19 PM.png]]
		-  만약 second level Row()의 child widget이 grouping 될 필요가 없다면 second level Row() 는 필요 없다.
- Feed contents 를 여러 라인으로 구성된 문자열을 이용하여 표시하려면 RichText() 와 nested TextSpan을 사용한다.


## Search View

- ![[Screenshot 2024-10-13 at 7.58.18 PM.png]]
- Search View에서는 AppBar를 보이지 않도록 한다.
	- 하단 navigation bar를 통해 view 전환을 하고, 현재 선택된 view 화면과 전환은 GetX BottomNavigationController 를 이용하여 구현
	- BottomNavigationController가 binding을 GetMaterialApp의 initialBinding 을 통해 하는 경우,  AppBar 가 생성된 후에 binding 되기 때문에 RunApp() 실행 전에  BottomNavigationController 초기화 할 필요
	- AppBar 를 보여 주지 않으려면 appBar 속성에 null 할당
  ```dart
appBar: BottomNavigationController.to.activeView() == BottomNavigation.home
    ? AppBar(
        title: Text("Onstagoram", style: GoogleFonts.lobsterTwo(color: Colors.black, fontSize: 24)),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_outline)),
          IconButton(
            icon: Icon(CupertinoIcons.paperplane),
            onPressed: () {},
          )
        ],
      )
    : null,
  ```
- Search keyword input은 TextField() widget을 사용한다.
    - TextField() widget 은 부모 widget 크기에 dependent 하기 때문에 크기를 SizedBox()로 감싸 크기를 조절 한다.
    - TextField() widget의 scrollPadding 속성은 const EdgeInsets.all(20.0)로 초기화 되어 있기에  EdgeInsets.all(0), 로 재설정 한다.
    - TextField() widget의 형태는 decoration: InputDecoration 를 사용한다.
        - 외곽선은 비활성화 되어 있을 때와 입력 받을 때를 구분하여 설정할 수 있다.
      ```dart
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.grey.shade200, width: 1)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.grey.shade200, width: 1)),
      ```

## Code

### Main view
```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onstagoram/app_getx_binding.dart';
import 'package:onstagoram/body.dart';
import 'package:onstagoram/controller/bottom_navigation_controller.dart';

void main() {
  Get.put(BottomNavigationController());
  runApp(OnstagoramApp());
}

class OnstagoramApp extends StatelessWidget {
  const OnstagoramApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        initialBinding: AppBinding(),
        theme: ThemeData(
            colorScheme: const ColorScheme.light(primary: Colors.white, secondary: Colors.black),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                showSelectedLabels: false, showUnselectedLabels: false, selectedItemColor: Colors.black),
            useMaterial3: true),
        home: Scaffold(
          appBar: BottomNavigationController.to.activeView() == BottomNavigation.home
              ? AppBar(
                  title: Text("Onstagoram", style: GoogleFonts.lobsterTwo(color: Colors.black, fontSize: 24)),
                  centerTitle: false,
                  actions: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.favorite_outline)),
                    IconButton(
                      icon: Icon(CupertinoIcons.paperplane),
                      onPressed: () {},
                    )
                  ],
                )
              : null,
          body: OnstagoramBody(),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 28,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.search, size: 28), label: 'Search')
            ],
            onTap: (index) {
              BottomNavigationController.to.tap(index);
            },
          ),
        ),
      );
    });
  }
}
```

### Home view
```dart
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:onstagoram/widget/mock_data_provider.dart';

final int UserCount = 25;

class HomeView extends StatelessWidget {
  final MockDataProvider dataProvider;

  HomeView({required this.dataProvider, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        UserStories(
          dataProvider: dataProvider,
        ),
        FeedList(dataProvider: dataProvider)
      ],
    ));
  }
}

class UserStories extends StatelessWidget {
  final MockDataProvider dataProvider;

  const UserStories({required this.dataProvider, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            List.generate(10, (index) => UserStory(dataProvider: dataProvider, label: dataProvider.getUser().userName)),
      ),
    );
  }
}

class UserStory extends StatelessWidget {
  final MockDataProvider dataProvider;
  final String label;

  const UserStory({required this.dataProvider, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            decoration: BoxDecoration(
                color: RandomColor.getColorObject(Options(colorType: ColorType.orange, luminosity: Luminosity.light)),
                borderRadius: BorderRadius.circular(40)),
          ),
          Text(label.length > 12 ? '${label.substring(0, 10)}..' : label),
          const SizedBox(
            height: 6,
          )
        ],
      ),
    );
  }
}

class FeedList extends StatelessWidget {
  final MockDataProvider dataProvider;

  const FeedList({required this.dataProvider, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 50,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Feed(
              userName: dataProvider.getUser().userName,
              likeCount: Random().nextInt(999),
              contents: dataProvider.getContents(),
              imagePath: dataProvider.getImageAssetPath(),
              location: dataProvider.getLocation(),
            ));
  }
}

class Feed extends StatelessWidget {
  final int likeCount;
  final String userName;
  final String contents;
  final String imagePath;
  final String location;

  const Feed(
      {required this.userName,
      required this.likeCount,
      required this.imagePath,
      required this.contents,
      required this.location,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                  margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                  decoration: BoxDecoration(
                      color: RandomColor.getColorObject(
                          Options(colorType: ColorType.orange, luminosity: Luminosity.light)),
                      borderRadius: BorderRadius.circular(20)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // align children widgets left
                  children: [Text(userName), Text(location)],
                ),
              ],
            ),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
              ],
            )
          ],
        ),
        SizedBox(
          height: 4,
        ),
        Image.asset(imagePath),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.favorite_outline)),
                  IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.chat_bubble)),
                  IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.paperplane)),
                ],
              ),
              Row(children: [
                IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.bookmark)),
              ])
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
          child: RichText(text: TextSpan(children: [TextSpan(text: contents, style: TextStyle(color: Colors.black))])),
        ),
        SizedBox(
          height: 12,
        )
      ],
    );
  }
}
```

### Search view
```dart
import 'package:flutter/material.dart';
import 'package:onstagoram/widget/mock_data_provider.dart';

class SearchView extends StatelessWidget {
  final MockDataProvider dataProvider;

  const SearchView({required this.dataProvider, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            FeedSearchBar(
              dataProvider: dataProvider,
            ),
            FeedGrid(dataProvider: dataProvider)
          ],
        ),
      ),
    );
  }
}

class FeedSearchBar extends StatelessWidget {
  final MockDataProvider dataProvider;

  FeedSearchBar({required this.dataProvider, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: TextField(
          cursorColor: Colors.black38,
          scrollPadding: EdgeInsets.all(0),
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade200,
              prefixIcon: Icon(Icons.search),
              hintText: 'search keyboard',
              hintStyle: TextStyle(color: Colors.black12),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey.shade200, width: 1)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey.shade200, width: 1)),
              contentPadding: EdgeInsets.all(0)),
        ),
      ),
    );
  }
}

class FeedGrid extends StatelessWidget {
  final MockDataProvider dataProvider;

  FeedGrid({required this.dataProvider, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.zero,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
          53, (index) => Container(child: Image.asset(dataProvider.getImageAssetPath()), color: Colors.transparent)),
    );
  }
}
```
