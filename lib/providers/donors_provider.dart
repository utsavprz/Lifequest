import 'package:lifequest/models/campaign.dart';
import 'package:lifequest/models/user.dart';
import 'package:riverpod/riverpod.dart';

final donorsProvider = StateNotifierProvider<DonorState, List<User>>(
  (ref) => DonorState(),
);

class DonorState extends StateNotifier<List<User>> {
  DonorState() : super([]);

  void updateDonorList(List<User> value) {
    state = value;
  }
}
