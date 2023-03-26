import 'package:lifequest/models/user_blood_request.dart';
import 'package:riverpod/riverpod.dart';

final bloodRequestProvider =
    StateNotifierProvider<BloodRequestState, List<UserBloodRequest>>(
  (ref) => BloodRequestState(),
);

class BloodRequestState extends StateNotifier<List<UserBloodRequest>> {
  BloodRequestState() : super([]);

  String? currentRequestId;

  void updateRecentBloodRequestList(List<UserBloodRequest> value) {
    state = value;
  }
}
