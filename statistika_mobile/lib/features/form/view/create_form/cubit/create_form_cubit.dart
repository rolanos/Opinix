import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/features/form/data/model/create_form_request.dart';
import 'package:statistika_mobile/features/form/data/repository/form_repository.dart';
import 'package:statistika_mobile/features/form/domain/model/form.dart';

part 'create_form_state.dart';

class CreateFormCubit extends Cubit<CreateFormState> {
  CreateFormCubit() : super(CreateFormEmpty());

  Future<void> createForm(
    String name,
    String description,
    String userId,
    String? typeId,
  ) async {
    if (typeId == null) {
      emit(
        CreateFormError(
          message: 'Укажите вид опроса',
        ),
      );
      return;
    }
    if (name.isEmpty) {
      emit(
        CreateFormError(
          message: 'Заполните название опроса',
        ),
      );
      return;
    }
    final request = CreateFormRequest(
      name: name,
      description: description,
      typeId: typeId,
      createdById: userId,
    );
    final result = await FormRepository().createForm(request);
    result.match(
      (e) => emit(CreateFormError(message: e.toString())),
      (f) => emit(CreateFormCreated(form: f)),
    );
  }
}
