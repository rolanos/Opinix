import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repository/form_repository.dart';
import '../../../domain/model/form.dart';

class MyFormsCubit extends Cubit<MyFormsState> {
  MyFormsCubit() : super(MyFormsEmpty());

  Future<void> getForms() async {
    if (state is MyFormsEmpty || state is MyFormsError) {
      emit(MyFormsLoading());
    }
    final result = await FormRepository().getUserForms();
    result.match(
      (e) => emit(
        MyFormsError(
          message: e.toString(),
        ),
      ),
      (allForms) async {
        emit(
          MyFormsInitial(
            forms: allForms,
          ),
        );
      },
    );
  }
}

@immutable
sealed class MyFormsState {}

final class MyFormsEmpty extends MyFormsState {}

final class MyFormsLoading extends MyFormsState {}

final class MyFormsError extends MyFormsState {
  MyFormsError({required this.message});

  final String message;
}

final class MyFormsInitial extends MyFormsState {
  MyFormsInitial({
    this.forms = const [],
  });

  final List<Form> forms;
}
