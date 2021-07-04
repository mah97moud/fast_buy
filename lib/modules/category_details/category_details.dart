import 'package:buy_now_demo/models/categories/categories_details_model.dart';
import 'package:buy_now_demo/modules/category_details/empty.dart';
import 'package:buy_now_demo/shared/app_cubit/cubit.dart';
import 'package:buy_now_demo/shared/app_cubit/states.dart';
import 'package:buy_now_demo/shared/components/widgets.dart';
import 'package:buy_now_demo/shared/styles/color.dart';
import 'package:buy_now_demo/shared/styles/my_icons_icons.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        var categoryList = AppCubit.get(context).categoriesDetailsList;
        return ConditionalBuilder(
          condition: categoryList != null,
          fallback: (context) => buildCircleProgressIndicator(
            height: 50.0,
            width: 50.0,
          ),
          builder: (_) => categoryList.length != 0
              ? Scaffold(
                  body: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 1,
                            childAspectRatio: 1 / 1.2,
                            crossAxisSpacing: 2.0,
                            mainAxisSpacing: 20.0,
                            children: List.generate(
                              // categoryModel.data.data.length,
                              categoryList.length,
                              (index) => buildProductItem(
                                context,
                                category: categoryList,
                                index: index,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : EmptyDetails(),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget buildProductItem(
    BuildContext context, {
    @required List<CategoryDetailsData> category,
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
              category[index].image,
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
                        category[index].name,
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        category[index].description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      if (category[index].discount != 0)
                        Row(
                          children: [
                            Text(
                              '\$${category[index].oldPrice.round()}',
                              style: category[index].oldPrice != null
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
                              '\%${category[index].discount}',
                            ),
                          ],
                        ),
                      if (category[index].price != null)
                        Text(
                          '\$${category[index].price.round()}',
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
                        color: AppCubit.get(context).inCart[category[index].id]
                            ? kAppOrangeRedColor
                            : null,
                      ),
                      onPressed: () {
                        AppCubit.get(context).addOrRemoveToCart(
                          productId: category[index].id,
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
                        color:
                            AppCubit.get(context).favourites[category[index].id]
                                ? kAppOrangeRedColor
                                : null,
                      ),
                      onPressed: () {
                        AppCubit.get(context).addOrRemoveFav(
                          productId: category[index].id,
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
}
