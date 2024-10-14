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
                borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.grey.shade200, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.grey.shade200, width: 1)),
          ),
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
