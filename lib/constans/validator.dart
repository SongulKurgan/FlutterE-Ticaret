class MyValidators{

  static String? displayNameValidator(String? displayName){
    if(displayName== null || displayName.isEmpty){
      return 'Görünen yer boş olamaz';
    }
    if(displayName.length<3 || displayName.length>20)
    {
      return '3 karakterden az ve 20 karakterden fazla olamaz';
    }
    return null;
  }

  //E-mail kontrolü(chat cbt den hazır aldım)
  static String? EmailValidator(String? value){
    if(value!.isEmpty)
    {
      return 'Lütfen email adresinizi giriniz';
    }
    if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
        .hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? PasswordValidator(String? value){
    if(value!.isEmpty)
    {
      return 'Lütfen email şifrenizi giriniz';
    }
    if(value.length<6){
      return 'Şifre 6 karakterden az olamaz';

    }

    return null;
  }

  static String? repeatPasswordValidator(String? value, String? password){
    if(value!=password)
    {
      return 'Parola eşleşmedi';
    }

    return null;
  }



}