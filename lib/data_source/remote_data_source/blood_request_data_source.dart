import 'package:dio/dio.dart';
import 'package:lifequest/app/constants.dart';
import 'package:lifequest/data_source/remote_data_source/response/blood_request_response.dart';
import 'package:lifequest/helper/http_service.dart';
import 'package:lifequest/helper/shared_preferences.dart';
import 'package:lifequest/main.dart';
import 'package:lifequest/models/user_blood_request.dart';
import 'package:lifequest/providers/blood_requests_provider.dart';

class UserBloodRequestRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<int> sendUserBloodRequest(UserBloodRequest bloodRequest) async {
    try {
      Response response = await _httpServices.post(Constant.userBloodRequestURL,
          data: bloodRequest,
          options: Options(
            headers: {
              "Authorization": "Bearer ${await SharedPref.getTokenFromPrefs()}",
            },
          ));
      print("responseStatusCode:${response.statusCode}");

      if (response.statusCode == 200) {
        // ? blood request sent success
        return 200;
      } else {
        // ? Internal server error
        return 0;
      }
    } catch (e) {
      if (e is DioError) {
        int statusCode = e.response!.statusCode!;
        // debugPrint("Error: $statusCode");
        // ? to receive status code 400 which validates if the user has recently sent a request
        return statusCode;
      }
      return 0;
    }
  }

  Future<List<UserBloodRequest>> getBloodRequests() async {
    try {
      Response response = await _httpServices.get(Constant.getBloodRequestURL,
          options: Options(
            headers: {
              "Authorization": "Bearer ${await SharedPref.getTokenFromPrefs()}",
            },
          ));

      if (response.statusCode == 200) {
        BloodRequestResponse bloodRequestResponse =
            BloodRequestResponse.fromJson(response.data);
        // Provider.of<BloodRequestProviders>(context, listen: false)
        //     .recentBloodRequestList = bloodRequestResponse.data!;
        container
            .read(bloodRequestProvider.notifier)
            .updateRecentBloodRequestList(bloodRequestResponse.data!);
        // ? blood request sent success
        return bloodRequestResponse.data!;
      } else {
        // ? Internal server error
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<UserBloodRequest?> getBloodRequestById(String requestId) async {
    try {
      Response response = await _httpServices.get(
        '${Constant.userBloodRequestURL}/$requestId',
        options: Options(
          headers: {
            "Authorization": "Bearer ${await SharedPref.getTokenFromPrefs()}",
          },
        ),
      );

      if (response.statusCode == 200) {
        UserBloodRequest bloodRequestResponse =
            UserBloodRequest.fromJson(response.data['data']);
        // Provider.of<BloodRequestProviders>(context, listen: false)
        //     .recentBloodRequestList = bloodRequestResponse.data!;

        // ? blood request sent success
        return bloodRequestResponse;
      } else {
        // ? Internal server error
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<UserBloodRequest?> updateUserBloodRequest(
      String requestId, Map<String, dynamic> data) async {
    try {
      Response response = await _httpServices.put(
        '${Constant.userBloodRequestURL}/$requestId',
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer ${await SharedPref.getTokenFromPrefs()}",
          },
        ),
      );

      if (response.statusCode == 200) {
        UserBloodRequest bloodRequestResponse =
            UserBloodRequest.fromJson(response.data['data']);
        // Provider.of<BloodRequestProviders>(context, listen: false)
        //     .recentBloodRequestList = bloodRequestResponse.data!;

        // ? blood request sent success
        return bloodRequestResponse;
      } else {
        // ? Internal server error
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<int> addDonationRecord(String requestId) async {
    try {
      Response response = await _httpServices.put(
        '${Constant.userBloodRequestURL}/addDonationRecord/$requestId',
        options: Options(
          headers: {
            "Authorization": "Bearer ${await SharedPref.getTokenFromPrefs()}",
          },
        ),
      );

      if (response.statusCode == 200) {
        return 1;
      } else {
        // ? Internal server error
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }
}
