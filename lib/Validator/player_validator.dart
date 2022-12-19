import 'package:email_validator/email_validator.dart';

mixin InputPlayerValidation{
  bool isValidName (String? name){
    if(name!.isEmpty || name.length < 3){
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
    if(jersey!.isEmpty || jersey.contains('.') || int.parse(jersey).isNegative || int.parse(jersey) < 1 || int.parse(jersey) > 99 ){
      return false;
    }
    return true;
  }

  bool isValidAge (String? age){
    if(age!.isEmpty || age.contains('.')|| int.parse(age).isNegative || int.parse(age) < 5 || int.parse(age) > 99){
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