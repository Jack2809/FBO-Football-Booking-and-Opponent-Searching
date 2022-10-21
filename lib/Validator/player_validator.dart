import 'package:email_validator/email_validator.dart';

mixin InputPlayerValidation{
  bool isValidName (String? name){
    if(name!.isEmpty){
      return false;
    }
    return true;
  }

  bool isValidPhone (String? phone){
    if(phone!.isEmpty || phone.length != 10){
      return false;
    }
    return true;
  }

  bool isValidJersey (String? jersey){
    if(jersey!.isEmpty || int.parse(jersey!).isNegative){
      return false;
    }
    return true;
  }

  bool isValidAge (String? age){
    if(age!.isEmpty || int.parse(age!).isNegative){
      return false;
    }
    return true;
  }

  bool isValidEmail(String? email){
    if(EmailValidator.validate(email!) == false){
      return false;
    }
    return true;
  }

}