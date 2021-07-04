import 'package:buy_now_demo/layouts/home/home_layout.dart';
import 'package:buy_now_demo/models/cart/cart_model.dart';
import 'package:buy_now_demo/shared/app_cubit/states.dart';
import 'package:buy_now_demo/shared/components/constants.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';

import '../../shared/app_cubit/cubit.dart';
import '../../shared/components/widgets.dart';
import '../../shared/styles/color.dart';
import '../../shared/styles/my_icons_icons.dart';

class CartScreen extends StatelessWidget {
  final CartModel cartModel;
  final length;
  final List<CartItems> cartItems;
  final state;

  const CartScreen({
    this.cartModel,
    this.length,
    this.cartItems,
    this.state,
  });
  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      fallback: (_) => buildCircleProgressIndicator(),
      condition: state is! CartDeleteLoadingState,
      builder: (_) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return buildAppCartItem(
                  _,
                  index,
                  cartItem: cartItems,
                  state: state,
                );
              },
              separatorBuilder: (_, index) => Container(
                width: 20.0,
              ),
              itemCount: length,
              physics: BouncingScrollPhysics(),
            ),
            SizedBox(
              height: 40.0,
            ),
            ConditionalBuilder(
              condition: state is! AppUpdateCartLoading,
              fallback: (_) => buildCircleProgressIndicator(
                height: 40.0,
                width: 40.0,
              ),
              builder: (_) => Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLang(context).totals,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          appLang(context).subTotal,
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                                color: kAppDarkColor,
                              ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              height: 1.0,
                              width: double.infinity,
                              color: kAppLightGreyColor,
                            ),
                          ),
                        ),
                        Text(
                          '\$${cartModel.data.subTotal}',
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                color: kAppDarkColor,
                                fontSize: 18.0,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Total',
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                                color: kAppDarkColor,
                              ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              height: 1.0,
                              width: double.infinity,
                              color: kAppLightGreyColor,
                            ),
                          ),
                        ),
                        Text(
                          '\$${cartModel.data.total}',
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                color: kAppDarkColor,
                                fontSize: 18.0,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: buildDefaultButton(
                        onPressed: () {},
                        text: 'Checkout',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildAppCartItem(
    BuildContext context,
    int index, {
    @required List<CartItems> cartItem,
    @required AppStates state,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        height: 150.0,
        child: Row(
          children: [
            Container(
              height: 120.0,
              width: 125.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  width: 1.0,
                  color: kAppLightGreyColor,
                ),
              ),
              child: Image(
                fit: BoxFit.contain,
                image: NetworkImage(cartItem[index].product.image),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem[index].product.name,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    cartItem[index].product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: kAppLightGreyColor,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildAppTextButton(
                          onPressed: () {
                            AppCubit.get(context).updateCart(
                              productId: cartItem[index].id,
                              quantity: ++cartItem[index].quantity,
                            );
                          },
                          text: '+',
                        ),
                        buildAppTextButton(
                          onPressed: () {},
                          text: '${cartItem[index].quantity}',
                          size: 16,
                        ),
                        buildAppTextButton(
                          onPressed: cartItem[index].quantity != 1
                              ? () {
                                  AppCubit.get(context).updateCart(
                                    productId: cartItem[index].id,
                                    quantity: --cartItem[index].quantity,
                                  );
                                }
                              : null,
                          text: '-',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${cartItem[index].product.price}',
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                  buildAppTextButton(
                    onPressed: () {
                      AppCubit.get(context)
                          .deleteCartItem(
                        productId: cartItems[index].id,
                        context: context,
                      )
                          .then((value) {
                        AppCubit.get(context).currentIndex = 0;
                        navigateTo(
                          context: context,
                          widgetScreen: HomeLayout(),
                        );
                      });
                    },
                    height: 50.0,
                    width: 40.0,
                    iconData: MyIcons.trash_empty,
                    backgroundColor: kAppDeleteColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
