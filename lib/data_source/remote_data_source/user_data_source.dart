import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lifequest/app/constants.dart';
import 'package:lifequest/data_source/remote_data_source/response/blood_request_response.dart';
import 'package:lifequest/data_source/remote_data_source/response/donors_response.dart';
import 'package:lifequest/data_source/remote_data_source/response/login_response.dart';

import 'package:lifequest/helper/http_service.dart';
import 'package:lifequest/helper/shared_preferences.dart';
import 'package:lifequest/main.dart';
import 'package:lifequest/models/user.dart';
import 'package:lifequest/models/user_blood_request.dart';
import 'package:lifequest/models/user_profile.dart';
import 'package:lifequest/providers/donors_provider.dart';
import 'package:lifequest/providers/user_provider.dart';
import 'package:lifequest/repository/user_repo.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class UserRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<int> addUser(User user) async {
    try {
      Response response = await _httpServices.post(
        Constant.usersRegisterURL,
        data: user,
      );
      // debugPrint("responseStatusCode:${response.statusCode}");

      if (response.statusCode == 200) {
        // ? registered success
        return 200;
      } else {
        // ? Internal server error
        return 0;
      }
    } catch (e) {
      if (e is DioError) {
        int statusCode = e.response!.statusCode!;
        // debugPrint("Error: $statusCode");
        // ? to receive status code 409 which validates if the user already exists or not
        return statusCode;
      }
      return 0;
    }
  }

  Future<bool> loginUser(
      BuildContext context, String email, String password) async {
    try {
      Response response =
          await _httpServices.post(Constant.usersLoginURL, data: {
        "email": email,
        "password": password,
      });

      LoginResponse loginResponse = LoginResponse.fromJson(response.data);

      if (response.statusCode == 200) {
        // ? store the token to sharedPrefs
        var token = loginResponse.token;
        await SharedPref.storeTokenInPrefs(token!);

        // ? store the userdata to sharedPrefs
        await SharedPref.setMap('userMap', loginResponse.data!);

        User user = User.fromJson(loginResponse.data!);
        // Provider.of<UserProvider>(context, listen: false).user = user;

        container.read(userProvider.notifier).setUser(user);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<User> getUserById(String id) async {
    try {
      Response response = await _httpServices.get(
        '${Constant.usersURL}/$id',
        options: Options(
          headers: {
            "Authorization": "Bearer ${await SharedPref.getTokenFromPrefs()}",
          },
        ),
      );
      if (response.statusCode == 200) {
        // final responseData = response.data['data'];
        User userdata = User.fromJson(response.data['data']);
        return userdata;
      } else {
        return User();
      }
    } catch (e) {
      return User();
    }
  }

  Future<int> addUserProfile(UserProfile userProfile) async {
    try {
      String id = await SharedPref.getMap('userMap').then((value) {
        return value['_id'];
      });

      Response response = await _httpServices.post(
        '${Constant.userProfileURL}/$id',
        options: Options(
          headers: {
            "Authorization": "Bearer ${await SharedPref.getTokenFromPrefs()}",
          },
        ),
        data: userProfile,
      );

      //  store the updated userdata to sharedPrefs
      SharedPref.removeString("userMap");
      print('Cleared previous user data');

      // store the userdata to sharedPrefs
      User userData = await UserRepositoryImpl().getUserById(id);

      SharedPref.setMap('userMap', userData.toJson());

      // Map<String, dynamic>? currentUser =
      //     (await getUserById(id)) as Map<String, dynamic>?;
      // await SharedPref.setMap("user", currentUser!['data']);
      print('Updated previous user data');

      if (response.statusCode == 200) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      print('error');
      return 0;
    }
  }

  Future<User?> updateUserProfile(
      Map<String, dynamic> userProfile, File? file) async {
    try {
      MultipartFile? image;
      if (file != null) {
        var mimeType = lookupMimeType(file.path);
        image = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
          contentType: MediaType("image", mimeType!.split("/")[1]),
        );
      }

      FormData formData = FormData.fromMap({
        ...userProfile,
        if (image != null) 'image': image,
      });

      Response response = await _httpServices.put(
        '${Constant.usersURL}/${container.read(userProvider)!.id}',
        options: Options(
          headers: {
            "Authorization": "Bearer ${await SharedPref.getTokenFromPrefs()}",
          },
        ),
        data: formData,
      );

      //  store the updated userdata to sharedPrefs
      SharedPref.removeString("userMap");
      print('Cleared previous user data');

      // store the userdata to sharedPrefs
      User userData = await UserRepositoryImpl()
          .getUserById(container.read(userProvider)!.id!);

      SharedPref.setMap('userMap', userData.toJson());
      print('Updated previous user data');

      if (response.statusCode == 200) {
        User userdata = User.fromJson(response.data['data']);
        container.read(userProvider.notifier).setUser(userdata);
        return userdata;
      } else {
        return null;
      }
    } catch (e) {
      print('error');
      return null;
    }
  }

  Future<List<User>> getDonors() async {
    try {
      Response response = await _httpServices.get(
        '${Constant.usersURL}/get_donors_my_area',
        options: Options(
          headers: {
            "Authorization": "Bearer ${await SharedPref.getTokenFromPrefs()}",
          },
        ),
      );
      if (response.statusCode == 200) {
        // final responseData = response.data['data'];
        DonorsResponse donorsResponse = DonorsResponse.fromJson(response.data);

        //? set data to provider
        container
            .read(donorsProvider.notifier)
            .updateDonorList(donorsResponse.data!);

        // print('userdata');
        // print(donorsResponse.data);
        return donorsResponse.data!;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<UserBloodRequest>> getDonationRecord(
      List<String> donationId) async {
    try {
      Response response = await _httpServices.get(
        '${Constant.usersURL}/getDonationRecords',
        options: Options(
          headers: {
            "Authorization": "Bearer ${await SharedPref.getTokenFromPrefs()}",
          },
        ),
        queryParameters: {
          "donationId": donationId,
        },
      );
      if (response.statusCode == 200) {
        // final responseData = response.data['data'];
        BloodRequestResponse donorsResponse =
            BloodRequestResponse.fromJson(response.data);

        // //? set data to provider
        // container
        //     .read(donorsProvider.notifier)
        //     .updateDonorList(donorsResponse.data!);

        // print('userdata');
        // print(donorsResponse.data!);
        return donorsResponse.data!;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<UserBloodRequest>> getRequestRecord(
      List<String> requestId) async {
    try {
      Response response = await _httpServices.get(
        '${Constant.usersURL}/getRequestRecords',
        options: Options(
          headers: {
            "Authorization": "Bearer ${await SharedPref.getTokenFromPrefs()}",
          },
        ),
        queryParameters: {
          "requestId": requestId,
        },
      );
      if (response.statusCode == 200) {
        // final responseData = response.data['data'];
        BloodRequestResponse donorsResponse =
            BloodRequestResponse.fromJson(response.data);

        // //? set data to provider
        // container
        //     .read(donorsProvider.notifier)
        //     .updateDonorList(donorsResponse.data!);

        // print('userdata');
        // print(donorsResponse.data!);
        return donorsResponse.data!;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
