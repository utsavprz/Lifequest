import 'package:lifequest/helper/shared_preferences.dart';

class CurrentUserDataSource {
  static Future<Map<String, dynamic>> getUserData() async {
    var userData = await SharedPref.getMap('userMap');

    return userData;
  }

  static Future<String?> getEmail() async {
    Map<String, dynamic> user = await getUserData();
    return user['email'];
  }

  static Future<String?> getFirstName() async {
    Map<String, dynamic> user = await getUserData();
    return user['profile']['firstName'];
  }

  static Future<Map<String, dynamic>?> getProfile() async {
    Map<String, dynamic> user = await getUserData();
    return user['profile'];
  }

  static Future<String?> getId() async {
    Map<String, dynamic> user = await getUserData();

    return user['_id'];
  }
}
