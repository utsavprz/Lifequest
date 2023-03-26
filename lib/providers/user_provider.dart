import 'package:lifequest/models/user.dart';
import 'package:riverpod/riverpod.dart';

final userProvider =
    StateNotifierProvider<UserNotifier, User?>((ref) => UserNotifier());

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  void setUser(User user) {
    state = user;
  }
}
