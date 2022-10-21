
mixin InputTeamValidation{
  bool isValidName (String? name){
    if(name!.isEmpty || name!.length < 6){
      return false;
    }
    return true;
  }
}