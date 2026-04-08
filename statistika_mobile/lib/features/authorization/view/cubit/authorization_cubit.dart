import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/core/utils/dio_client.dart';
import 'package:statistika_mobile/core/utils/shared_preferences_manager.dart';
import 'package:statistika_mobile/features/authorization/data/dto/login_message.dart';
import 'package:statistika_mobile/features/authorization/data/repository/authorization_repository.dart';
import 'package:statistika_mobile/features/authorization/domain/model/user.dart';

part 'authorization_state.dart';

class AuthorizationCubit extends Cubit<AuthorizationState> {
  AuthorizationCubit() : super(AuthorizationEmpty());

  Future<void> login(String email, String password) async {
    if (state is AuthorizationLoading) return;
    if (kReleaseMode && (email.trim().isEmpty || password.trim().isEmpty)) {
      emit(
        AuthorizationError(
          message: 'Заполните все поля',
        ),
      );
      return;
    }

    emit(AuthorizationLoading());

    if (kDebugMode && email.isEmpty) {
      email = 'fixsad.dev@gmail.com';
    }
    if (kDebugMode && password.isEmpty) {
      password = 'ZbkNZY588DUJyIP0';
    }

    final result = await AuthorizationRepository().login(
      email.trim(),
      password.trim(),
    );

    result.match(
      (e) => emit(AuthorizationError(message: e.message)),
      (l) => emit(
        AuthorizationAcceptRedirect(message: l),
      ),
    );
  }

  Future<void> register(String email, String password) async {
    if (state is AuthorizationLoading) return;

    emit(AuthorizationLoading());

    if (kDebugMode && email.isEmpty) {
      email = 'ivan.kostenko2003@gmail.com';
    }
    if (kDebugMode && password.isEmpty) {
      password = '321321321';
    }

    final result = await AuthorizationRepository().register(
      email.trim(),
      password.trim(),
    );

    result.match(
      (e) => emit(AuthorizationError(message: e.message)),
      (l) => emit(
        AuthorizationAcceptRedirect(message: l),
      ),
    );
  }

  Future<void> confirmEmail(String code) async {
    final state = this.state;
    if (state is AuthorizationLoading || state is AuthorizationAcceptLoading) {
      return;
    }

    if (state is AuthorizationAcceptEmail) {
      final email = state.message.email;
      if (email == null) {
        emit(
          AuthorizationError(
            message: AppConstants.defaultError,
          ),
        );
        return;
      }

      emit(
        AuthorizationAcceptLoading(
          message: state.message,
        ),
      );

      await SharedPreferencesManager.clear();
      final result = await AuthorizationRepository().confirmEmail(
        email,
        code.trim(),
      );

      result.match(
        (e) => emit(
          AuthorizationAcceptError(
            errorMessage: e.message,
            message: state.message,
          ),
        ),
        (l) => emit(
          AuthorizationInited(
            user: l,
          ),
        ),
      );
    }
  }

  Future<void> logout() async {
    if (state is AuthorizationLoading) return;
    emit(AuthorizationLoading());
    await DioClient.cookie.deleteAll();
    await SharedPreferencesManager.clear();
    await AuthorizationRepository().logout();
    emit(AuthorizationEmpty());
  }
}
