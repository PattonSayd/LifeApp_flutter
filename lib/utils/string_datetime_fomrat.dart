import 'package:intl/intl.dart';

extension DateTime on String {
  String formatDateTime(String oldFormat, String newFormat) {
    var tempDate = DateFormat(oldFormat).parse(this);
    return DateFormat(newFormat).format(tempDate).toString();
  }
}
