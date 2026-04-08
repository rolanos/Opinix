import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/core/utils/shared_preferences_manager.dart';
import 'package:statistika_mobile/features/authorization/data/dto/update_user_info_request.dart';
import 'package:statistika_mobile/features/authorization/data/repository/authorization_repository.dart';
import 'package:statistika_mobile/features/authorization/data/repository/user_info_repository.dart';
import 'package:statistika_mobile/features/authorization/data/repository/user_repository.dart';
import 'package:statistika_mobile/core/enum/gender.dart';
import 'package:statistika_mobile/features/authorization/domain/model/user.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileEmpty());

  Future<void> init(User user) async {
    emit(UserProfileInitial(user: user));
    await update();
  }

  Future<void> initById() async {
    final userId = await SharedPreferencesManager.getUserId();
    final isAnonimous = await SharedPreferencesManager.getAnonymous();
    if (userId == null || isAnonimous) {
      emit(UserProfileAnonymous());
    } else if (state is UserProfileEmpty) {
      final updated = await UserRepository().getUserById(
        userId,
      );

      updated.match(
        (e) => emit(UserProfileError(message: e.toString())),
        (u) async {
          emit(UserProfileInitial(user: u));
          final isModerator = await AuthorizationRepository().checkModerator();
          isModerator.match((e) {}, (r) {
            emit(UserProfileInitial(
              user: u,
              isModerator: r,
            ));
          });
        },
      );
    }
  }

  Future<void> update() async {
    final state = this.state;

    if (state is UserProfileInitial) {
      final updated = await UserRepository().getUserById(state.user.id);

      updated.match(
        (e) => emit(UserProfileError(message: e.toString())),
        (u) async {
          emit(
            UserProfileInitial(
              user: u,
              isModerator: state.isModerator,
            ),
          );
          final isModerator = await AuthorizationRepository().checkModerator();
          isModerator.match((e) {}, (r) {
            emit(
              UserProfileInitial(
                user: u,
                isModerator: r,
              ),
            );
          });
        },
      );
    } else {
      final userId = await SharedPreferencesManager.getUserId();
      if (userId != null) {
        final updated = await UserRepository().getUserById(
          userId,
        );

        updated.match(
          (e) => emit(UserProfileError(message: e.toString())),
          (u) async {
            emit(UserProfileInitial(user: u));
            final isModerator =
                await AuthorizationRepository().checkModerator();
            isModerator.match((e) {}, (r) {
              emit(UserProfileInitial(
                user: u,
                isModerator: r,
              ));
            });
          },
        );
      }
    }
  }

  Future<void> updateUserProfileInfo(
    String? name,
    Gender? genderValue,
    DateTime? birthday, {
    bool withLoading = false,
  }) async {
    if (state is UserProfileLoading) return;

    final stateSnap = state;
    if (withLoading) {
      emit(UserProfileLoading(user: state.user));
    }
    if (stateSnap is UserProfileInitial && stateSnap.user.userInfo != null) {
      final userInfo = await UserInfoRepository().updateUserInfo(
        UpdateUserInfoRequest(
          id: stateSnap.user.userInfo!.id,
          name: name,
          isMan: genderValue?.isMan(),
          birthday: birthday,
        ),
      );
      userInfo.match(
        (e) {
          emit(UserProfileError(
            message: e.toString(),
            user: state.user,
          ));
          emit(stateSnap);
        },
        (u) => update(),
      );
    } else {
      emit(stateSnap);
    }
  }

  Future<void> updateProfilePhoto(XFile? photo) async {
    final userInfoId = state.user?.userInfo?.id;
    if (photo == null || userInfoId == null) return;
    final result = await UserInfoRepository().updatePhoto(
      userInfoId,
      photo,
    );
    result.match(
      (e) {
        emit(UserProfileError(
          message: e.toString(),
          user: state.user,
        ));
        emit(state);
      },
      (_) async {
        await update();
      },
    );
  }

  void clear() {
    emit(UserProfileEmpty());
  }
}
