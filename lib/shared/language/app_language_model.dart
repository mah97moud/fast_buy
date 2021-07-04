class AppLanguageModel {
  String english;
  String arabic;
  String title1;
  String title2;
  String title3;
  String body1;
  String body2;
  String body3;
  String welcome;
  String signupText1;
  String signupText2;
  String email;
  String password;
  String signIn;
  String signUp;
  String donthaveAnAccount;
  String haveAnAccount;
  String validMail;
  String validPassword;
  String validName;
  String validPhone;
  String continueText;
  String home;
  String discover;
  String shoppingCart;
  String category;
  String settings;
  String cart;
  String categories;
  String totals;
  String subTotal;
  String name;
  String phone;

  AppLanguageModel({
    this.english,
    this.arabic,
    this.title1,
    this.title2,
    this.title3,
    this.body1,
    this.body2,
    this.body3,
    this.welcome,
    this.signupText1,
    this.signupText2,
    this.email,
    this.password,
    this.signIn,
    this.signUp,
    this.haveAnAccount,
    this.donthaveAnAccount,
    this.validMail,
    this.validPassword,
    this.validName,
    this.validPhone,
    this.continueText,
    this.home,
    this.settings,
    this.cart,
    this.categories,
    this.totals,
    this.subTotal,
    this.name,
    this.phone,
    this.discover,
    this.category,
    this.shoppingCart,
  });

  AppLanguageModel.fromJson(Map<String, dynamic> json) {
    english = json['english'];
    arabic = json['arabic'];
    title1 = json['title1'];
    title2 = json['title2'];
    title3 = json['title3'];
    body1 = json['body1'];
    body2 = json['body2'];
    body3 = json['body3'];
    welcome = json['welcome'];
    signupText1 = json['signupText1'];
    signupText2 = json['signupText2'];
    email = json['email'];
    password = json['password'];
    signIn = json['signIn'];
    signUp = json['signUp'];
    haveAnAccount = json['haveAnAccount'];
    donthaveAnAccount = json['donthaveAnAccount'];
    validMail = json['validMail'];
    validPassword = json['validPassword'];
    validName = json['validName'];
    validPhone = json['validPhone'];
    continueText = json['continue'];
    home = json['home'];
    settings = json['settings'];
    cart = json['cart'];
    categories = json['categories'];
    name = json['name'];
    phone = json['phone'];
    totals = json['totals'];
    subTotal = json['subTotal'];
    discover = json['discover'];
    shoppingCart = json['shoppingCart'];
    category = json['category'];
  }

  // Map<String, dynamic> toJson() {
  //    Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['english'] = this.english;
  //   data['arabic'] = this.arabic;
  //   data['title1'] = this.title1;
  //   data['title2'] = this.title2;
  //   data['title3'] = this.title3;
  //   data['body1'] = this.body1;
  //   data['body2'] = this.body2;
  //   data['body3'] = this.body3;
  //   return data;
  // }
}
