import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/features/form/domain/model/form.dart';

class ActiveFormCubit extends Cubit<ActiveFormState> {
  ActiveFormCubit() : super(const ActiveFormState());

  void init(Form form) => emit(ActiveFormState(form: form));
}

@immutable
final class ActiveFormState {
  final Form? form;

  const ActiveFormState({this.form});
}
