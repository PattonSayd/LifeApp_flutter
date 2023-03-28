extension DoubleDoy on String {
  String replaceDotPlace(int place) {
    String value = this;
    String returnValue = '';
    RegExp regex = RegExp(r'(\d)');
    for (int i = regex.allMatches(value).length - 1; i >= 0; i--) {
      var match = regex.allMatches(value).toList()[i];
      returnValue = match.group(1)! + returnValue;
      if (i == regex.allMatches(value).length - place) {
        returnValue = '.$returnValue';
      }
    }
    return returnValue;
  }
}
