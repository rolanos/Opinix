import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/core/repository/question_repository.dart';

import '../../form/domain/model/question.dart';

part 'moderation_state.dart';

class ModerationCubit extends Cubit<ModerationState> {
  ModerationCubit() : super(ModerationEmpty());

  Future<void> getGeneralQuestionForModerate() async {
    final state = this.state;
    if (state is ModerationEmpty) {
      emit(ModerationLoading());
    }
    final result = await QuestionRepository().nextToModerateQuestion();

    result.match(
      (e) => emit(
        ModerationError(
          message: e.toString(),
        ),
      ),
      (q) => emit(ModerationInitial(question: q)),
    );
  }

  Future<void> moderate(bool moderate) async {
    final state = this.state;

    if (state is ModerationInitial) {
      final result = await QuestionRepository().confirmModerate(
        state.question.id,
        moderate,
      );

      result.match(
        (e) => emit(
          ModerationError(message: e.toString()),
        ),
        (_) async {
          emit(ModerationSendSuccessLoading());
          await getGeneralQuestionForModerate();
        },
      );
    }
  }
}
