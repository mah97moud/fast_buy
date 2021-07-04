import 'package:buy_now_demo/shared/styles/color.dart';
import 'package:buy_now_demo/shared/styles/my_icons_icons.dart';
import 'package:flutter/material.dart';

class EmptyCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              child: Icon(
                MyIcons.shopping_basket,
                color: kAppRedColor,
                size: 100.0,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'Empty Cart',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
