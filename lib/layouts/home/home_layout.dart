import 'package:buy_now_demo/shared/app_cubit/cubit.dart';
import 'package:buy_now_demo/shared/app_cubit/states.dart';
import 'package:buy_now_demo/shared/components/constants.dart';
import 'package:buy_now_demo/shared/components/widgets.dart';
import 'package:buy_now_demo/shared/styles/color.dart';
import 'package:buy_now_demo/shared/styles/my_icons_icons.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        int currentIndex = AppCubit.get(context).currentIndex;
        var model = AppCubit.get(context).homeModel;
        var categoriesModel = AppCubit.get(context).categoriesModel;
        var cartModel = AppCubit.get(context).cartModel;
        return ConditionalBuilder(
          condition:
              model != null && categoriesModel != null && cartModel != null,
          fallback: (_) => Scaffold(
            body: buildCircleProgressIndicator(
              height: 40.0,
              width: 40.0,
            ),
          ),
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: AppCubit.get(context).titleWidget(
                index: currentIndex,
                context: context,
              ),
              centerTitle: AppCubit.get(context).isCenter,
            ),
            body: AppCubit.get(context).bottomWidgets[currentIndex],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: kAppRedColor,
                    width: 1.0,
                  ),
                ),
              ),
              child: BottomNavigationBar(
                onTap: (index) {
                  AppCubit.get(context).changeBottomIndex(index);
                },
                currentIndex: currentIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(MyIcons.home),
                    label: appLang(context).home,
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      height: 33.0,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Icon(MyIcons.shopping_basket),
                          ),
                          ConditionalBuilder(
                            fallback: (_) => buildCircleProgressIndicator(
                              width: 10.0,
                              height: 10.0,
                            ),
                            condition: state is! AppLoadingCartState,
                            builder: (_) =>
                                AppCubit.get(context).cartItemLength != 0
                                    ? CircleAvatar(
                                        radius: 8.0,
                                        backgroundColor: kAppRedColor,
                                        child: Text(
                                          '${AppCubit.get(context).cartModel.data.cartItems.length}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .overline,
                                        ),
                                      )
                                    : Container(),
                          ),
                        ],
                      ),
                    ),
                    label: appLang(context).cart,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(MyIcons.transfer_1),
                    label: appLang(context).categories,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(MyIcons.settings),
                    label: appLang(context).settings,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
