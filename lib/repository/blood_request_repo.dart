import 'package:lifequest/data_source/remote_data_source/blood_request_data_source.dart';
import 'package:lifequest/models/user_blood_request.dart';

abstract class BloodRequestRepository {
  Future<int> sendUserBloodRequest(UserBloodRequest bloodRequest);
  Future<List<UserBloodRequest>> getBloodRequests();
  Future<UserBloodRequest?> getBloodRequestById(String requestId);
  Future<int> addDonationRecord(String requestId);
  Future<UserBloodRequest?> updateUserBloodRequest(
      String requestId, Map<String, dynamic> data);
}

class BloodRequestRepositoryImpl extends BloodRequestRepository {
  @override
  Future<int> sendUserBloodRequest(UserBloodRequest bloodRequest) {
    return UserBloodRequestRemoteDataSource()
        .sendUserBloodRequest(bloodRequest);
  }

  @override
  Future<List<UserBloodRequest>> getBloodRequests() {
    return UserBloodRequestRemoteDataSource().getBloodRequests();
  }

  @override
  Future<UserBloodRequest?> getBloodRequestById(String requestId) {
    return UserBloodRequestRemoteDataSource().getBloodRequestById(requestId);
  }

  @override
  Future<UserBloodRequest?> updateUserBloodRequest(
      String requestId, Map<String, dynamic> data) {
    return UserBloodRequestRemoteDataSource()
        .updateUserBloodRequest(requestId, data);
  }

  @override
  Future<int> addDonationRecord(String requestId) {
    return UserBloodRequestRemoteDataSource().addDonationRecord(requestId);
  }
}
