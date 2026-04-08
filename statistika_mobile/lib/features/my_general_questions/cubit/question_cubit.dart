import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/core/model/analitical/analitical_complex.dart';
import 'package:statistika_mobile/core/repository/analitical_repository.dart';

import '../../../core/repository/question_repository.dart';
import '../../form/domain/model/question.dart';

part 'question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  QuestionCubit() : super(QuestionEmpty());

  Future<void> getQuestion(String? id) async {
    if (state is QuestionEmpty) {
      emit(QuestionLoading());
    }
    if (id == null || id.isEmpty == true) {
      emit(
        QuestionError(
          message: 'Не удалось загрузить вопрос',
        ),
      );
      return;
    }
    final result = await QuestionRepository().getQuestionById(id);
    result.match(
      (e) => emit(QuestionError(message: e.toString())),
      (q) async {
        emit(QuestionInitialLoaded(question: q));
        final analiticResult = await AnaliticalRepository().getAnalitic(
          q.id,
        );
        analiticResult.match(
          (e) => emit(
            QuestionInitial(
              question: q,
            ),
          ),
          (a) => emit(
            QuestionInitial(
              question: q,
              analitical: a,
            ),
          ),
        );
      },
    );
  }
}
