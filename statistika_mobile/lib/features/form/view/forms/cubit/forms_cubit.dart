import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/features/form/data/repository/form_repository.dart';

import '../../../domain/model/form.dart';

class AllFormsCubit extends Cubit<AllFormsState> {
  AllFormsCubit() : super(AllFormsLoading());

  Future<void> getForms() async {
    if (state is AllFormsEmpty || state is AllFormsError) {
      emit(AllFormsLoading());
    }
    final result = await FormRepository().getAllForms();
    result.match(
      (e) => emit(
        AllFormsError(
          message: e.toString(),
        ),
      ),
      (allForms) async {
        emit(
          AllFormsInitial(
            forms: allForms,
          ),
        );
      },
    );
  }
}

@immutable
sealed class AllFormsState {}

final class AllFormsEmpty extends AllFormsState {}

final class AllFormsLoading extends AllFormsState {}

final class AllFormsError extends AllFormsState {
  AllFormsError({required this.message});

  final String message;
}

final class AllFormsInitial extends AllFormsState {
  AllFormsInitial({
    this.forms = const [],
  });

  final List<Form> forms;
}
