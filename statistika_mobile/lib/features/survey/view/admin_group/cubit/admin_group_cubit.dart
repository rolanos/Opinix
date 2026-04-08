import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/core/dto/delete_admin_group/delete_admin_group.dart';
import 'package:statistika_mobile/core/dto/update_admin_group/update_admin_group.dart';
import 'package:statistika_mobile/core/model/classifier/classifier.dart';
import 'package:statistika_mobile/features/survey/data/repository/admin_group_repository.dart';
import 'package:statistika_mobile/features/survey/domain/model/admin_group/admin_group.dart';

import '../../../../../core/dto/create_admin_group/create_admin_group.dart';

part 'admin_group_state.dart';

class AdminGroupCubit extends Cubit<AdminGroupState> {
  AdminGroupCubit() : super(const AdminGroupEmpty(surveyId: ''));

  Future<void> init(String? surveyId) async {
    if (surveyId == null) {
      emit(
        AdminGroupError(
          surveyId: surveyId,
          message: 'Что-то пошло не так, попробуйте позже',
        ),
      );
      return;
    }

    emit(AdminGroupLoading(surveyId: surveyId));

    final config = await AdminGroupRepository().getAdminGroups(surveyId);

    config.match(
      (e) => emit(
        AdminGroupError(
          surveyId: surveyId,
          message: e.toString(),
        ),
      ),
      (a) => emit(
        AdminGroupInitial(
          surveyId: surveyId,
          adminGroups: a,
        ),
      ),
    );
  }

  Future<void> update() async {
    var state = this.state;

    final config = await AdminGroupRepository().getAdminGroups(state.surveyId!);

    final surveyId = state.surveyId;
    config.match(
      (e) {
        emit(
          AdminGroupError(
            surveyId: surveyId,
            message: e.toString(),
          ),
        );
        update();
      },
      (a) => emit(AdminGroupInitial(
        adminGroups: a,
        surveyId: surveyId,
      )),
    );
  }

  Future<void> add(String? userEmail) async {
    var state = this.state;
    if (userEmail == null) {
      return;
    }
    if (state is AdminGroupInitial) {
      final addResult = await AdminGroupRepository().addAdminGroup(
        CreateAdminGroup(
          userEmail: userEmail,
          surveyId: state.surveyId!,
        ),
      );

      final surveyId = state.surveyId;
      addResult.match(
        (e) {
          emit(
            AdminGroupError(
              surveyId: surveyId,
              message: e.toString(),
            ),
          );
          update();
        },
        (a) => update(),
      );
    }
  }

  Future<void> updateAdminGroup(AdminGroup adminGrop, Classifier role) async {
    var state = this.state;
    if (state is AdminGroupInitial) {
      final addResult = await AdminGroupRepository().updateAdminGroup(
        UpdateAdminGroup(
          userId: adminGrop.user?.id ?? '',
          roleId: role.id,
          surveyId: adminGrop.surveyId,
        ),
      );

      addResult.match(
        (e) {
          emit(
            AdminGroupError(
              surveyId: state.surveyId,
              message: e.toString(),
            ),
          );
          update();
        },
        (a) => update(),
      );
    }
  }

  Future<void> deleteAdminGroup(AdminGroup adminGrop) async {
    var state = this.state;
    if (state is AdminGroupInitial) {
      final addResult = await AdminGroupRepository().deleteAdminGroup(
        DeleteAdminGroup(
          userId: adminGrop.user?.id ?? '',
          surveyId: adminGrop.surveyId,
        ),
      );

      addResult.match(
        (e) {
          emit(
            AdminGroupError(
              surveyId: state.surveyId,
              message: e.toString(),
            ),
          );
          update();
        },
        (a) => update(),
      );
    }
  }
}
