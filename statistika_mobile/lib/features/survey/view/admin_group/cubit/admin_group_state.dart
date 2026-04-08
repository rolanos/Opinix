part of 'admin_group_cubit.dart';

@immutable
sealed class AdminGroupState {
  final String? surveyId;

  const AdminGroupState({
    required this.surveyId,
  });
}

final class AdminGroupLoading extends AdminGroupState {
  const AdminGroupLoading({required super.surveyId});
}

final class AdminGroupEmpty extends AdminGroupState {
  const AdminGroupEmpty({required super.surveyId});
}

final class AdminGroupError extends AdminGroupInitial {
  AdminGroupError({
    required super.surveyId,
    super.adminGroups = const [],
    required this.message,
  });

  final String message;
}

final class AdminGroupInitial extends AdminGroupState {
  AdminGroupInitial({
    required super.surveyId,
    required this.adminGroups,
  });

  final List<AdminGroup> adminGroups;
}
