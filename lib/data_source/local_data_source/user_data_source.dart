import 'package:lifequest/helper/object_box.dart';
import 'package:lifequest/helper/shared_preferences.dart';
import 'package:lifequest/models/user.dart';
import 'package:lifequest/repository/user_repo.dart';
import 'package:lifequest/state/objectbox_state.dart';

class UserDataSource {
  ObjectBoxInstance get objectBoxInstance => ObjectBoxState.objectBoxInstance!;

  Future<int> addUser(User user) async {
    try {
      return objectBoxInstance.addUser(user);
    } catch (e) {
      return 0;
    }
  }

  Future<User> getUserById(int id) {
    try {
      return Future.value(objectBoxInstance.getUserById(id));
    } catch (e) {
      throw Exception('Error in getting user $id');
    }
  }

  Future<List<User>> getAllUser() async {
    return objectBoxInstance.getAllUser();
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      // print(objectBoxInstance.loginUser(email, password));
      if (objectBoxInstance.loginUser(email, password) != null) {
        int id = await SharedPref.getInt('objectBoxId');

        User userData = await UserRepositoryImpl().getUserById(id.toString());

        SharedPref.setMap('userMap', userData.toJson());

        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Error occured : ${e.toString()}');
    }
  }

  Future<List<int>> addDonors(List<User> donorslst) async {
    try {
      return objectBoxInstance.addDonors(donorslst);
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<User>> getAllDonors() async {
    try {
      return objectBoxInstance.getAllDonors();
    } catch (e) {
      print(e);
      return [];
    }
  }
}
