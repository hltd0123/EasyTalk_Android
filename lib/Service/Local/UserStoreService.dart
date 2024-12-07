import 'package:dacn/Model/User.dart';
import 'package:dacn/Service/APICall/UserService.dart';
import 'package:dacn/Service/Local/GetDataFromMap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserStoreService{
  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }
  static Future<String?> getPass() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('pass');
  }
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
  static Future<bool> setEmail(String email) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      return true;
    }
    on Exception{
      return false;
    }
  }
  static Future<bool> setPass(String pass) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('pass', pass);
      return true;
    }
    on Exception{
      return false;
    }
  }
  static Future<bool> setToken(String token) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      return true;
    }
    on Exception{
      return false;
    }
  }
  static Future<bool> reloadToken() async {
    try {
      await UserService.login(await getEmail() ?? '', await getPass() ?? '');
      return true;
    }
    on Exception{
      return false;
    }
  }
  static Future<Map<String, dynamic>?> getCurrentUserAndAchievements() async {
    var data = await UserService.getUserProfile();
    if(data == null){
      reloadToken();
      data = await UserService.getUserProfile();
    }
    if (data == null){
      return null;
    }
    return data;
  }
  static Future<bool> changePassword(String currentPassword, String newPassword, String confirmPassword) async {
    if(await UserService.changePassword(currentPassword, newPassword, confirmPassword)){
      return true;
    }
    reloadToken();
    if(await UserService.changePassword(currentPassword, newPassword, confirmPassword)){
      return true;
    }
    return false;
  }
  static Future<bool> updateProfile(String userName, String email) async {
    if(await UserService.updateProfile(userName, email)){
      return true;
    }
    reloadToken();
    if(await UserService.updateProfile(userName, email)){
      return true;
    }
    return false;
  }
}