import 'package:buy_now_demo/modules/cart/cart_screen.dart';
import 'package:buy_now_demo/modules/cart/empty_cart_screen.dart';
import 'package:buy_now_demo/shared/app_cubit/cubit.dart';
import 'package:buy_now_demo/shared/app_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (_, state) {
        var cartModel = AppCubit.get(_).cartModel;
        var length = AppCubit.get(_).cartItemLength;
        var cartItems = AppCubit.get(_).cartItems;
        return length == 0
            ? EmptyCartScreen()
            : CartScreen(
                cartItems: cartItems,
                cartModel: cartModel,
                length: length,
                state: state,
              );
      },
      listener: (_, state) {},
    );
  }
}

// ConditionalBuilder(
//
// builder: (_) => ,
// )
