import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lifequest/app/network_connectivity.dart';
import 'package:lifequest/data_source/local_data_source/user_data_source.dart';
import 'package:lifequest/data_source/remote_data_source/user_data_source.dart';
import 'package:lifequest/helper/shared_preferences.dart';
import 'package:lifequest/main.dart';
import 'package:lifequest/models/user.dart';
import 'package:lifequest/models/user_blood_request.dart';
import 'package:lifequest/providers/donors_provider.dart';

import '../models/user_profile.dart';

abstract class UserRepository {
  // Future<User> getUserById(String id);
  Future<int> addUser(User user);
  Future<int> addUserProfile(UserProfile userProfile);
  Future<User> getUserById(String id);
  Future<User?> updateUserProfile(Map<String, dynamic> userProfile, File? file);
  Future<List<User>> getDonors();
  Future<List<UserBloodRequest>> getDonationRecord(List<String> donationId);
  Future<List<UserBloodRequest>> getRequestRecord(List<String> requestId);
  Future<bool> loginUser(BuildContext context, String email, String password);
}

class UserRepositoryImpl extends UserRepository {
  @override
  Future<int> addUser(User user) async {
    if (await NetworkConnectivity.isOnline()) {
      return UserRemoteDataSource().addUser(user);
    }
    int statuscode = 500;
    await UserDataSource().addUser(user).then((value) => {
          if (value == 409)
            {statuscode = 409}
          else if (value != 0)
            {
              SharedPref.setInt(value, 'objectBoxId'),
              statuscode = 200,
            }
          else
            {statuscode = 500}
        });
    return statuscode;
  }

  @override
  Future<User> getUserById(String id) async {
    if (await NetworkConnectivity.isOnline()) {
      return UserRemoteDataSource().getUserById(id);
    }
    return UserDataSource().getUserById(int.parse(id));
  }

  @override
  Future<List<User>> getDonors() async {
    if (await NetworkConnectivity.isOnline()) {
      return UserRemoteDataSource().getDonors();
    } else {
      List<User> donorsLst = [];
      UserDataSource().getAllDonors().then((value) {
        container.read(donorsProvider.notifier).updateDonorList(value);
        donorsLst = value;
      });
      return donorsLst;
    }
  }

  @override
  Future<bool> loginUser(
      BuildContext context, String email, String password) async {
    if (await NetworkConnectivity.isOnline()) {
      // ignore: use_build_context_synchronously
      return UserRemoteDataSource().loginUser(context, email, password);
    }
    return UserDataSource().loginUser(email, password);
  }

  @override
  Future<int> addUserProfile(UserProfile userProfile) async {
    return UserRemoteDataSource().addUserProfile(userProfile);
  }

  @override
  Future<List<UserBloodRequest>> getDonationRecord(List<String> donationId) {
    return UserRemoteDataSource().getDonationRecord(donationId);
  }

  @override
  Future<List<UserBloodRequest>> getRequestRecord(List<String> requestId) {
    return UserRemoteDataSource().getRequestRecord(requestId);
  }

  @override
  Future<User?> updateUserProfile(
      Map<String, dynamic> userProfile, File? file) {
    return UserRemoteDataSource().updateUserProfile(userProfile, file);
  }
}
