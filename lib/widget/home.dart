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
