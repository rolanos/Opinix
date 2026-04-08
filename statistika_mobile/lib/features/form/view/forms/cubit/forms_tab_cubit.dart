import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class FormsTabCubit extends Cubit<FormsTabState> {
  FormsTabCubit() : super(const FormsTabState());

  void init(TabController? newController) =>
      emit(FormsTabState(controller: newController));

  void goToIndex(int index) {
    state.controller?.animateTo(index);
  }
}

@immutable
class FormsTabState {
  final TabController? controller;

  const FormsTabState({this.controller});
}
