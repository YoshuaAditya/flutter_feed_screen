import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_feed_screen/main/models/feed.dart';
import 'package:flutter_feed_screen/main/utils/text_styles.dart';
import 'package:flutter_feed_screen/main/view/widgets/description_bar.dart';
import 'package:flutter_feed_screen/main/view/widgets/social_bar.dart';
import 'package:flutter_feed_screen/main/view/widgets/title_bar.dart';
import 'package:flutter_feed_screen/main/view/widgets/user_bar.dart';
import 'package:http/http.dart' as http;

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final _scrollController = ScrollController();

  final List<Product> _list = [];

  bool _isLoading = true;
  int skipItems = 0;
  int limitItems = 10;
  int listIndex = 0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_loadMore);
    _getData();
  }

  Feed? feedResponse;
  _getData() async {
    try {
      String url =
          "https://dummyjson.com/products?limit=$limitItems&skip=$skipItems";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        feedResponse = Feed.fromJson(json.decode(res.body));
        _list.addAll(feedResponse?.products as Iterable<Product>);
        _isLoading = false;
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  void _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        skipItems += 5;
        _isLoading = true;
        _getData();
      });
    }
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isLoading = true;
      _getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: Container(
          color: const Color.fromARGB(255, 235, 235, 235),
          height: double.infinity,
          child: Column(children: [
            Flexible(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 10),
                separatorBuilder: (BuildContext context, int index) {
                  return const ColoredBox(
                    color: Colors.green,
                    child: SizedBox(width: 50),
                  );
                },
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Feed",
                          textAlign: TextAlign.start,
                          style: TextStyles.feedTitle,
                        ),
                      ),
                    );
                  }
                  index -= 1;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TitleBar(
                            title: _list[index].title,
                            sku: "\$${_list[index].price.toString()}",
                            thumbnail: _list[index].thumbnail,
                          ),
                          DescriptionBar(
                              description: _list[index].description,
                              thumbnail: _list[index].thumbnail),
                          UserBar(
                              name: _list[index].title,
                              timestamp: _list[index].category),
                          SocialBar(
                              comments: _list[index].id,
                              likes: _list[index].stock),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: _list.isEmpty ? 1 : _list.length + 1,
              ),
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
          ]),
        ),
      ),
    );
  }
}
