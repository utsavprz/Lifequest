import 'dart:io';

import 'package:lifequest/models/campaign.dart';

import '../models/user.dart';
import '../objectbox.g.dart';
import 'package:path_provider/path_provider.dart';


class ObjectBoxInstance {
  late final Store _store;
  late final Box<User> _user;
  late final Box<Campaign> _campaigns;
  late final Box<User> _donors;

  ObjectBoxInstance(this._store) {
    _user = Box<User>(_store);
    _campaigns = Box<Campaign>(_store);
    _donors = Box<User>(_store);
    // insertUser();
  }

  static Future<ObjectBoxInstance> init() async {
    var dir = await getApplicationDocumentsDirectory();
    final store = Store(
      getObjectBoxModel(),
      directory: '${dir.path}/lifequest',
    );

    return ObjectBoxInstance(store);
  }

  Future<bool> isEmailExists(String email) async {
    User? user = _user.query(User_.email.equals(email)).build().findFirst();
    return user != null;
  }

  Future<int> addUser(User user) async {
    if (await isEmailExists(user.email!)) {
      // print('Email Exists');
      return 409;
    } else {
      return _user.put(user);
    }
  }

  List<User> getAllUser() {
    return _user.getAll();
  }

  User? getUserById(int id) {
    return _user.get(id);
  }

  User getUserByEmail(String email) {
    return _user.query(User_.email.equals(email)).build().findFirst()!;
  }

  // void insertUser() {
  //   print('inserting user');
  //   List<User> lstUsers = getAllUser();

  //   if (lstUsers.isEmpty) {
  //     UserProfile profile = UserProfile()
  //       ..firstName = 'Utsav'
  //       ..lastName = 'Prajapati'
  //       ..age = 22
  //       ..gender = 'Male'
  //       ..phoneNumber = '0000000000'
  //       ..city = 'Bhaktapur'
  //       ..streetName = 'Kamalbinayak'
  //       ..role = 'Admin'
  //       ..bloodType = 'A+';

  //     addUser(User(
  //       email: 'utsavprajapati17@gmail.com',
  //       password: 'password',
  //       profile: profile,
  //     ));

  //     print(profile);
  //   } else {
  //     print(lstUsers);
  //   }
  // }

  User? loginUser(String email, String password) {
    return _user
        .query(User_.email.equals(email) & User_.password.equals(password))
        .build()
        .findFirst();
  }

  // Delete Store and all boxes
  static Future<void> deleteDatabase() async {
    var dir = await getApplicationDocumentsDirectory();
    Directory('${dir.path}/lifequest').deleteSync(recursive: true);
  }

  Future<List<int>> addCampaigns(List<Campaign> campaigns) async {
    try {
      return _campaigns.putMany(campaigns);
    } catch (e) {
      return [];
    }
  }

  Future<List<Campaign>> getAllCampaigns() async {
    try {
      final campaigns = _campaigns.getAll();

      return campaigns;
    } catch (e) {
      return [];
    }
  }

  Future<List<int>> addDonors(List<User> donors) async {
    try {
      return _donors.putMany(donors);
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<User>> getAllDonors() async {
    try {
      final donors = _donors.getAll();
      return donors;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
