
mixin InputTeamValidation{
  bool isValidName (String? name){
    if(name!.isEmpty || name!.length < 6){
      return false;
    }
    return true;
  }

  bool isValidDescription (String? description){
    if(description!.isEmpty || description!.length < 10){
      return false;
    }
    return true;
  }

}