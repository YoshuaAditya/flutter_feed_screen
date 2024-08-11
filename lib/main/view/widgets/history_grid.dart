import 'package:flutter/material.dart';
import 'package:flutter_feed_screen/main/utils/assets.dart';
import 'package:flutter_feed_screen/main/utils/text_styles.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HistoryGrid extends StatelessWidget {
  const HistoryGrid({
    super.key,
    required this.index,
    required this.gridAxisCount,
  });
  final int index;
  final int gridAxisCount;

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: InkResponse(
          enableFeedback: true,
          child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    //                   <--- left side
                    color: index % gridAxisCount != 0
                        ? Colors.grey
                        : Colors.transparent,
                    width: 1.5,
                  ),
                  top: BorderSide(
                    //                   <--- left side
                    color: index >= gridAxisCount
                        ? Colors.grey
                        : Colors.transparent,
                    width: 1.5,
                  ),
                ),
              ),
              child: ColoredBox(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Assets.history),
                    const Text("History", style: TextStyles.p10),
                  ],
                ),
              )),
          onTap: () => {
                Fluttertoast.showToast(
                    msg: "History",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                    fontSize: 16.0)
              }),
    );
  }
}
