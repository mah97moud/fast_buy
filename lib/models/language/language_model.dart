class LanguageModel {
  final String language;
  final String code;

  LanguageModel({
    this.language,
    this.code,
  });
}

List<LanguageModel> languageList = [
  LanguageModel(
    language: 'English',
    code: 'en',
  ),
  LanguageModel(
    language: 'العربيه',
    code: 'ar',
  ),
];
