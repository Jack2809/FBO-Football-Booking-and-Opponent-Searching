

import 'package:email_validator/email_validator.dart';

mixin InputUserUpdateValidation{

  bool isValidName (String? name){
    if(name!.isEmpty){
      return false;
    }
    return true;
  }

  bool isValidAdrress (String? address){
    if(address!.isEmpty || address.length < 10){
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

  bool isValidPhone (String? phone){
    if(phone!.isEmpty || phone.length != 10){
      return false;
    }
    return true;
  }

  bool isValidBirthday (String? birthday){
    if(birthday!.isEmpty){
      return false;
    }
    return true;
  }

}