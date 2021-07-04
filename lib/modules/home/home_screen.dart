import 'package:buy_now_demo/models/categories/categories_model.dart';
import 'package:buy_now_demo/shared/app_cubit/cubit.dart';
import 'package:buy_now_demo/shared/app_cubit/states.dart';
import 'package:buy_now_demo/shared/components/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        var model = AppCubit.get(context).homeModel;
        var categoryModel = AppCubit.get(context).categoriesModel;
        return ConditionalBuilder(
          fallback: (_) => buildCircleProgressIndicator(
            height: 40.0,
            width: 40.0,
          ),
          condition: state is! AppLoadingState,
          builder: (_) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200,
                    viewportFraction: 1,
                    // aspectRatio: 16 / 9,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    // onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: model.data.banners
                      .map(
                        (item) => Container(
                          // color: kAppRedColor,
                          width: double.infinity,
                          child: Center(
                            child: Image.network(
                              item.image,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 180,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Container(
                  height: 140.0,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      return buildCategoryItem(
                        context,
                        model: categoryModel,
                        index: index,
                      );
                    },
                    separatorBuilder: (_, index) => Container(
                      width: 20.0,
                    ),
                    itemCount: categoryModel.data.data.length,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 2.3,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                    children: List.generate(
                      model.data.products.length,
                      (index) => buildProductItem(
                        context,
                        productModel: model.data.products[index],
                        index: index,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget buildCategoryItem(context,
      {@required CategoriesModel model, @required int index}) {
    return InkWell(
      onTap: () {
        AppCubit.get(context).getCategoryDetails(
          categoryId: model.data.data[index].id,
          context: context,
        );
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: Container(
              height: 100.0,
              child: Image(
                image: NetworkImage(
                  model.data.data[index].image,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            model.data.data[index].name,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}
