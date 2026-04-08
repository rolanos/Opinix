import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/core/model/analitical/analitical_complex.dart';
import 'package:statistika_mobile/core/repository/analitical_repository.dart';
import 'package:statistika_mobile/features/form/data/repository/section_repository.dart';
import 'package:statistika_mobile/features/form/domain/model/question.dart';

import '../../../../../core/dto/analitic_request/analitic_request.dart';

part 'form_analitic_state.dart';

class FormAnaliticCubit extends Cubit<FormAnaliticState> {
  FormAnaliticCubit() : super(FormAnaliticEmpty());

  Future<void> update(
    String? formId, {
    bool? isMan,
    bool? isWoman,
    int? startAge,
    int? endAge,
  }) async {
    if (formId == null) {
      emit(FormAnaliticError(message: 'Ошибка! Попробуйте позже'));
      return;
    }
    emit(FormAnaliticLoading());

    final sections = await SectionRepository().getSections(formId);

    bool? gender;
    if (isMan != isWoman) {
      if (isMan == true) {
        gender = true;
      }
      if (isWoman == true) {
        gender = false;
      }
    }

    AnaliticRequest analiticRequest = AnaliticRequest(
      gender: gender,
      ageFrom: startAge,
      ageTo: endAge,
    );

    sections.match(
      (e) => emit(FormAnaliticError(message: e.toString())),
      (s) async {
        if (s.isNotEmpty) {
          final section = s.first;
          final analiticList = <AnaliticComplexResult>[];
          await for (final question in Stream.fromIterable(section.questions)) {
            final analiticByQuestion = await AnaliticalRepository().getAnalitic(
              question.id,
              analiticRequest: analiticRequest,
            );

            analiticByQuestion.match(
              (e) {},
              (a) => analiticList.add(a),
            );
          }
          emit(
            FormAnaliticInitial(
              formId: formId,
              analitics: analiticList,
              questions: section.questions,
            ),
          );
        }
      },
    );
  }
}
