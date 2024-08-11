import 'package:flutter/material.dart';
import 'package:flutter_feed_screen/main/models/feed.dart';
import 'package:flutter_feed_screen/main/utils/utils_colors.dart';
import 'package:flutter_feed_screen/main/utils/text_styles.dart';
import 'package:flutter_feed_screen/main/view/widgets/description_bar.dart';
import 'package:flutter_feed_screen/main/view/widgets/expanded_app_bar_content.dart';
import 'package:flutter_feed_screen/main/view/widgets/button/location_button.dart';
import 'package:flutter_feed_screen/main/view/widgets/social_bar.dart';
import 'package:flutter_feed_screen/main/view/widgets/title_bar.dart';
import 'package:flutter_feed_screen/main/view/widgets/user_bar.dart';
import 'package:flutter_feed_screen/main/viewmodel/product_view_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final _scrollController = ScrollController();
  ProductViewModel viewModel = ProductViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getData();
    _scrollController.addListener(_loadMore);
  }

  void _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      viewModel.skipItems += 10;
      viewModel.getData();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    viewModel.clearProducts();
    viewModel.getData();
  }

  List<Widget> _buildList(List<Product> products) {
    List<Widget> listItems = [];

    listItems.add(const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Text(
          "Feed",
          textAlign: TextAlign.start,
          style: TextStyles.feedTitle,
        ),
      ),
    ));
    for (int i = 0; i < products.length; i++) {
      listItems.add(Container(
        margin: const EdgeInsets.only(bottom: 10),
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleBar(
                title: products[i].title,
                sku: "\$${products[i].price.toString()}",
                thumbnail: products[i].thumbnail,
              ),
              DescriptionBar(
                  description: products[i].description,
                  thumbnail: products[i].thumbnail),
              UserBar(name: products[i].title, timestamp: products[i].category),
              SocialBar(comments: products[i].id, likes: products[i].stock),
            ],
          ),
        ),
      ));
    }

    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: _handleRefresh,
      child: Container(
        color: const Color.fromARGB(255, 235, 235, 235),
        height: double.infinity,
        child: ChangeNotifierProvider<ProductViewModel>(
            create: (BuildContext context) => viewModel,
            child: Consumer<ProductViewModel>(builder: (context, value, _) {
              return Column(children: [
                Flexible(
                    child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    const SliverPersistentHeader(
                      pinned: true,
                      delegate: MyHeaderDelegate(),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate(
                            _buildList(viewModel.products))),
                  ],
                )),
                if (viewModel.isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
              ]);
            })),
      ),
    ));
  }
}

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  const MyHeaderDelegate();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = shrinkOffset / maxExtent;
    const threshold = 0.5;

    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: progress > threshold ? 1 : progress,
            child: const ColoredBox(
              color: UtilsColors.mainGreen,
            ),
          ),
          AppBar(
            toolbarHeight: 100,
            backgroundColor: Colors.transparent,
            title: progress > threshold
                ? LocationButton(
                    isContrast: true,
                    text: 'Japan',
                    voidCallback: () => {
                          Fluttertoast.showToast(
                              msg: "Location 1",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0)
                        })
                : const Text(""),
            flexibleSpace: progress > threshold
                ? const Text("")
                : const ExpandedAppBarContent(),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                color: Colors.white,
                onPressed: () => {
                  Fluttertoast.showToast(
                      msg: "Search",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 16.0)
                },
              ),
              IconButton(
                icon: const Icon(Icons.qr_code),
                color: Colors.white,
                onPressed: () => {
                  Fluttertoast.showToast(
                      msg: "QR CODE",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 16.0)
                },
              ),
            ],
            elevation: 0,
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 400;

  @override
  double get minExtent => 84;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
