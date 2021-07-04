import 'package:buy_now_demo/shared/app_cubit/cubit.dart';
import 'package:buy_now_demo/shared/components/widgets.dart';
import 'package:buy_now_demo/shared/network/repository.dart';
import 'package:buy_now_demo/shared/user_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user/user_model.dart';

class UserCubit extends Cubit<UserStates> {
  final Repository _repository;
  UserCubit(this._repository) : super(UserInitState());

  static UserCubit get(context) => BlocProvider.of(context);

  UserModel userModel;

  userLogin({
    @required String email,
    @required String password,
    @required BuildContext context,
  }) {
    emit(UserLoginLoadingState());
    _repository
        .userLogin(
      email: email,
      password: password,
    )
        .then((value) {
      userModel = UserModel.fromJson(value.data);
      if (userModel.status != true) {
        showToast(
          text: UserCubit.get(context).userModel.message,
          color: ToastColors.ERROR,
        );
      }
      AppCubit.get(context).getHomeData();
      AppCubit.get(context).getCategoriesData();
      emit(UserLoginSuccessState(
        userModel,
      ));
    }).catchError((error) {
      // emit(UserLoginErrorState(error));
    });
  }

  userSignup({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
    @required BuildContext context,
  }) {
    emit(UserLoginLoadingState());
    _repository
        .userSignUp(
      phone: phone,
      name: name,
      email: email,
      password: password,
    )
        .then((value) {
      userModel = UserModel.fromJson(value.data);
      if (userModel.status != true) {
        print(userModel.message);
        showToast(
          text: UserCubit.get(context).userModel.message,
          color: ToastColors.ERROR,
        );
      }
      AppCubit.get(context).getHomeData();
      AppCubit.get(context).getCategoriesData();
      emit(UserLoginSuccessState(
        userModel,
      ));
    }).catchError((error) {
      emit(UserLoginErrorState(error));
    });
  }
}
