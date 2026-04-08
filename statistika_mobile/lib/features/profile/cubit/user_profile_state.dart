part of 'user_profile_cubit.dart';

@immutable
sealed class UserProfileState {
  final User? user;

  const UserProfileState({this.user});
}

final class UserProfileAnonymous extends UserProfileState {
  @override
  User? get user => null;
}

final class UserProfileEmpty extends UserProfileState {
  @override
  User? get user => null;
}

final class UserProfileLoading extends UserProfileState {
  const UserProfileLoading({
    super.user,
  });
}

final class UserProfileError extends UserProfileState {
  const UserProfileError({
    required this.message,
    super.user,
  });

  final String message;
}

final class UserProfileInitial extends UserProfileState {
  const UserProfileInitial({
    required this.user,
    this.isModerator = false,
  });

  final bool isModerator;

  @override
  final User user;

  //if true then not equals
  bool notCompare(String? name, bool? isMan, DateTime? birthday) {
    if (name != null) {
      if (user.userInfo?.name != name) {
        return true;
      }
    }

    if (user.userInfo?.isMan != isMan) {
      return true;
    }
    if (birthday != null) {
      if (user.userInfo?.birthday?.compareTo(birthday) != 0) {
        return true;
      }
    }
    return false;
  }
}
