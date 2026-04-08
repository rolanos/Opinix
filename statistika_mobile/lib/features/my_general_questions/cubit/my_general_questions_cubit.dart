import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/core/repository/question_repository.dart';
import 'package:statistika_mobile/features/form/domain/model/question.dart';

part 'my_general_questions_state.dart';

class MyGeneralQuestionsCubit extends Cubit<MyGeneralQuestionsState> {
  MyGeneralQuestionsCubit() : super(MyGeneralQuestionsEmpty());

  Future<void> getMyGeneralQuestions() async {
    if (state is MyGeneralQuestionsEmpty) {
      emit(MyGeneralQuestionsLoading());
    }
    final result = await QuestionRepository().getMyGeneralQuestions();
    result.match(
      (e) => emit(MyGeneralQuestionsError(message: e.toString())),
      (list) => emit(
        MyGeneralQuestionsInitial(questions: list),
      ),
    );
  }

  Future<void> deleteQuestion(Question question) async {
    emit(MyGeneralQuestionsLoading());
    final result = await QuestionRepository().deleteQuestion(
      question.id,
    );
    result.match(
      (e) => emit(MyGeneralQuestionsError(message: e.toString())),
      (list) => getMyGeneralQuestions(),
    );
  }
}
