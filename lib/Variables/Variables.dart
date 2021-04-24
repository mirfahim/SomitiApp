import 'package:shared_preferences/shared_preferences.dart';

class Variables{
  static Variables to = Variables();
  initial()async{
    prefss = await SharedPreferences.getInstance();
  }
  SharedPreferences prefss;
  static int depositAmount;
  static int expenseAmount;
  static var selectCate;
  static int foodAmount;
  static int labourAmount;
  static String password = "0";
}