import 'package:buy_now_demo/shared/app_cubit/cubit.dart';
import 'package:buy_now_demo/shared/app_cubit/states.dart';
import 'package:buy_now_demo/shared/components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (_, state) {
        var model = AppCubit.get(context).categoriesModel;
        return ListView.separated(
          itemBuilder: (_, index) {
            return buildCategoryItem(
              _,
              index: index,
              model: model,
              onTap: () {
                AppCubit.get(context).getCategoryDetails(
                  categoryId: model.data.data[index].id,
                  context: context,
                );
              },
            );
          },
          separatorBuilder: (_, index) => buildSeparator(),
          itemCount: model.data.data.length,
        );
      },
      listener: (_, state) {},
    );
  }
}
