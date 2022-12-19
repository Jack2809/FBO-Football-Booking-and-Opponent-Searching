

mixin InputPlayerReviewValidation{

  bool isValidComment(String? comment) {
    if (comment!.isEmpty || comment!.length < 25) {
      return false;
    }
    return true;
  }

}