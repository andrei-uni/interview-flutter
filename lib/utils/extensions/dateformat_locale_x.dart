import 'package:intl/intl.dart';

extension DateFormatLocale on DateFormat {
  static DateFormat get ru {
    return DateFormat('d MMMM yyyy г. в H:mm', 'ru');
  }
}
