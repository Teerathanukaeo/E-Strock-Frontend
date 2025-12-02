import 'package:intl/intl.dart';

class P01VAR {
  static DateTime now = DateTime.now();
  static String Time = DateFormat('hh:mm').format(now);
  static String Day = DateFormat('dd').format(now);
  static String Month = DateFormat('MMMM').format(now);
  static String Year = DateFormat('yyyy').format(now);
  static double pcs = 0;
  static String Mat = '';
  static String Name = '';
  static int Volume = 0;
  static String Customer = '';
  static String Remark = '';
  static String remainQty = '';
  static String Machine = '';
}
