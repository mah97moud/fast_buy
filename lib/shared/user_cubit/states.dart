import '../../models/user/user_model.dart';

abstract class UserStates {}

class UserInitState extends UserStates {}

class UserLoginLoadingState extends UserStates {}

class UserLoginSuccessState extends UserStates {
  final UserModel userModel;

  UserLoginSuccessState(this.userModel);
}

class UserLoginErrorState extends UserStates {
  final String error;

  UserLoginErrorState(this.error) {
    print(error.toString());
  }
}

class UserSignupLoadingState extends UserStates {}

class UserSignupSuccessState extends UserStates {
  final UserModel userModel;

  UserSignupSuccessState(this.userModel);
}

class UserSignupErrorState extends UserStates {
  final String error;

  UserSignupErrorState(this.error) {
    print(error.toString());
  }
}
