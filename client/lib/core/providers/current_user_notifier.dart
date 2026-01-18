import 'package:client/features/auth/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserNotifierProvider = NotifierProvider<CurrentUserNotifier, UserModel?>(
  CurrentUserNotifier.new,
);

class CurrentUserNotifier extends Notifier<UserModel?> {
  @override
  UserModel? build() {
    return null;
  }

  void setUser(UserModel user) {
    state = user;
  }
}
