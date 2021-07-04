import 'package:buy_now_demo/models/categories/categories_model.dart';
import 'package:buy_now_demo/models/home/home_model.dart';
import 'package:buy_now_demo/models/language/language_model.dart';
import 'package:buy_now_demo/shared/app_cubit/cubit.dart';
import 'package:buy_now_demo/shared/styles/color.dart';
import 'package:buy_now_demo/shared/styles/my_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../app_cubit/cubit.dart';
import '../styles/color.dart';

Widget buildDefaultButton({
  @required onPressed,
  @required text,
}) {
  return Container(
    width: double.infinity,
    height: 45.0,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
      ),
    ),
  );
}

Container buildLanguageItem(
  BuildContext context, {
  LanguageModel model,
  int index,
}) {
  return Container(
    child: InkWell(
      onTap: () {
        AppCubit.get(context).changeSelectedLanguage(index);
        AppCubit.get(context).setAppDirection(code: model.code);
      },
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                model.language,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            if (AppCubit.get(context).selectedLanguage[index])
              Icon(
                AppCubit.get(context).isArabic
                    ? MyIcons.left_arrow_2
                    : MyIcons.right_arrow_1,
              ),
          ],
        ),
      ),
    ),
  );
}

Container buildSeparator() {
  return Container(
    height: 1.0,
    color: kAppLightGreyColor,
  );
}
// Show toast method

enum ToastColors {
  SUCCESS,
  ERROR,
  WARNING,
}
Color setToastColor(ToastColors color) {
  Color c;

  switch (color) {
    case ToastColors.SUCCESS:
      c = Colors.green;
      break;
    case ToastColors.ERROR:
      c = Colors.red;
      break;
    case ToastColors.WARNING:
      c = Colors.amber;
      break;
  }
  return c;
}

void showToast({
  @required String text,
  @required ToastColors color,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: setToastColor(color),
      textColor: Colors.white,
      fontSize: 16.0,
    );
// End show Toast

// Start Navigation

navigateAndFinish({
  @required BuildContext context,
  @required Widget widgetScreen,
}) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widgetScreen,
      ),
      (Route<dynamic> route) => false,
    );

navigateTo({
  @required BuildContext context,
  @required Widget widgetScreen,
}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widgetScreen,
      ),
    );

// End Navigation

TextFormField buildTextFormField(
  BuildContext context, {
  @required String text,
  @required String validateText,
  bool isObscure,
  TextInputType keyboardType,
  TextEditingController control,
  Icon icon,
}) {
  return TextFormField(
    keyboardType: keyboardType,
    obscureText: isObscure ?? false,
    controller: control,
    decoration: InputDecoration(
      labelText: text,
      prefixIcon: icon ?? null,
      border: OutlineInputBorder(),
    ),
    cursorColor: kAppGreyColor,
    style: Theme.of(context).textTheme.bodyText1,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return validateText;
      }
      return null;
    },
  );
}

//Start ProgressIndicator

Widget linerProgressIndicator() => Container(
      height: 40.0,
      //new
      child: LiquidLinearProgressIndicator(
        value: 0.25, // Defaults to 0.5.

        valueColor: AlwaysStoppedAnimation(
          kAppRedColor,
        ), // Defaults to the current Theme's accentColor.

        backgroundColor:
            Colors.white, // Defaults to the current Theme's backgroundColor.

        borderColor: Colors.red,

        borderWidth: 5.0,

        borderRadius: 12.0,

        direction: Axis
            .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.

        center: Text("Login..."),
      ),
    );
Widget circleProgressIndicator({
  double radius,
  String text,
}) =>
    Center(
      child: CircularPercentIndicator(
        radius: radius ?? 50.0,
        lineWidth: 5.0,
        percent: 0.60,
        center: Text(text ?? "80%"),
        progressColor: kAppLightRedColor,
        animationDuration: 1,
        circularStrokeCap: CircularStrokeCap.round,
        animation: true,
        // totalSteps: 10,
        // currentStep: 6,
        // selectedColor: kAppLightRedColor,
        // width: 100,
        // roundedCap: (_, isSelected) => isSelected,
        // circularDirection: CircularDirection.clockwise,
      ),
    );
Widget circleProgressIndicatorSolid({
  double height,
  double width,
}) =>
    Center(
      child: Container(
        width: width ?? 50.0,
        height: height ?? 50.0,
        child: LiquidCircularProgressIndicator(
          value: 0.4, // Defaults to 0.5.

          valueColor: AlwaysStoppedAnimation(
            kAppRedColor,
          ), // Defaults to the current Theme's accentColor.

          backgroundColor:
              Colors.white, // Defaults to the current Theme's backgroundColor.

          borderColor: Colors.red,

          borderWidth: 5.0,

          direction: Axis
              .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.

          // center: Text("Loading..."),
        ),
      ),
    );

// Product Widget method

Widget buildProductItem(
  BuildContext context, {
  Products productModel,
  @required int index,
}) {
  return Column(
    children: [
      SizedBox(
        height: 10.0,
      ),
      Container(
        height: 200.0,
        child: Image(
          fit: BoxFit.contain,
          image: NetworkImage(
            productModel.image,
          ),
        ),
      ),
      SizedBox(
        height: 10.0,
      ),
      Expanded(
        child: Container(
          padding: EdgeInsets.all(10.0),
          color: kAppLightGreyColor,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      productModel.name,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      productModel.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (productModel.discount != 0)
                      Row(
                        children: [
                          Text(
                            '\$${productModel.oldPrice.round()}',
                            style: productModel.oldPrice != null
                                ? Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w300,
                                      color: kAppGreyColor,
                                      decoration: TextDecoration.lineThrough,
                                    )
                                : Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w300,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Container(
                              width: 1.0,
                              height: 10.0,
                              color: kAppGreyColor,
                            ),
                          ),
                          Text(
                            '\%${productModel.discount}',
                          ),
                        ],
                      ),
                    if (productModel.price != null)
                      Text(
                        '\$${productModel.price.round()}',
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w300,
                            ),
                      ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    splashRadius: 20.0,
                    iconSize: 20.0,
                    alignment: Alignment.centerRight,
                    // splashColor: kAppOrangeRedColor,
                    icon: Icon(
                      MyIcons.shopping_basket_1,
                      size: 25.0,
                      color: AppCubit.get(context).inCart[productModel.id]
                          ? kAppOrangeRedColor
                          : null,
                    ),
                    onPressed: () {
                      AppCubit.get(context).addOrRemoveToCart(
                        productId: productModel.id,
                        context: context,
                      );
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  IconButton(
                    splashRadius: 20.0,
                    iconSize: 20.0,
                    alignment: Alignment.centerRight,
                    icon: Icon(
                      MyIcons.speech_bubble,
                      size: 25.0,
                      color: AppCubit.get(context).favourites[productModel.id]
                          ? kAppOrangeRedColor
                          : null,
                    ),
                    onPressed: () {
                      AppCubit.get(context).addOrRemoveFav(
                        productId: productModel.id,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// Product Widget method

Container buildAppTextButton({
  double height,
  double width,
  String text,
  IconData iconData,
  @required Function onPressed,
  double size,
  Color backgroundColor,
}) {
  return Container(
    width: width ?? 35.0,
    height: height ?? 35.0,
    decoration: BoxDecoration(
      color: backgroundColor ?? null,
    ),
    child: TextButton(
      child: text != null
          ? Text(
              text ?? '',
              style: TextStyle(
                fontSize: size ?? 25.0,
              ),
            )
          : Icon(
              iconData,
              color: kAppLightGreyColor,
            ),
      onPressed: onPressed,
    ),
  );
}

Center buildCircleProgressIndicator({double height, double width}) {
  return Center(
    child: Container(
      width: width ?? 20.0,
      height: height ?? 20.0,
      child: CircularProgressIndicator(
        backgroundColor: kAppRedColor,
        valueColor: AlwaysStoppedAnimation(kAppWhiteColor),
      ),
    ),
  );
}

ListTile buildCategoryItem(
  context, {
  @required CategoriesModel model,
  @required int index,
  @required Function onTap,
}) {
  return ListTile(
    contentPadding: EdgeInsets.all(15.0),
    onTap: onTap,
    leading: Container(
      width: 100.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Image(
        image: NetworkImage(
          model.data.data[index].image,
        ),
      ),
    ),
    title: Text(
      model.data.data[index].name,
    ),
    trailing: Icon(MyIcons.right_arrow),
  );
}
