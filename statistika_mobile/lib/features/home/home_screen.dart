import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/features/authorization/view/cubit/authorization_cubit.dart';

import '../../core/constants/constants.dart';
import '../form/view/fill_form/cubit/fill_form/active_form_cubit.dart';
import '../form/view/forms/cubit/forms_cubit.dart';
import '../form/view/forms/cubit/forms_tab_cubit.dart';
import '../general_question/view/cubit/general_question_cubit.dart';
import '../my_general_questions/cubit/my_general_questions_cubit.dart';
import '../profile/cubit/user_profile_cubit.dart';
import '../survey/view/cubit/survey_cubit.dart';
import 'cubit/question_types_cubit.dart';
import 'cubit/survey_roles_cubit.dart';
import 'cubit/survey_types_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  // ============================ Handle Back Pressed ==============================

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<bool> didPopRoute() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthorizationCubit, AuthorizationState>(
      listener: (context, state) {
        if (state is AuthorizationEmpty) {
          context.read<UserProfileCubit>().clear();
          context.goNamed(
            NavigationRoutes.welcome,
          );
        }
      },
      child: MultiBlocProvider(
        providers: [
          //Основная часть
          BlocProvider(
            create: (context) => SurveyCubit()..getSurveys(),
          ),
          BlocProvider(
            create: (context) => AllFormsCubit()..getForms(),
          ),
          BlocProvider(
            create: (context) => ActiveFormCubit(),
          ),
          BlocProvider(
            create: (context) => GeneralQuestionCubit()..getGeneralQuestion(),
          ),
          BlocProvider(
            create: (context) =>
                MyGeneralQuestionsCubit()..getMyGeneralQuestions(),
          ),

          //Классификации/справочники
          BlocProvider(
            create: (context) => QuestionTypesCubit()..update(),
          ),
          BlocProvider(
            create: (context) => SurveyRolesCubit()..update(),
          ),
          BlocProvider(
            create: (context) => SurveyTypesCubit()..update(),
          ),

          // Глобальные контроллеры
          BlocProvider(
            create: (context) => FormsTabCubit(),
          ),
        ],
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(child: widget.navigationShell),
          bottomNavigationBar: showBottomNavigationBar()
              ? Container(
                  decoration: BoxDecoration(
                    boxShadow: AppTheme.shadow,
                  ),
                  child: BottomNavigationBar(
                    currentIndex: widget.navigationShell.currentIndex,
                    onTap: (value) {
                      widget.navigationShell.goBranch(
                        value,
                        initialLocation:
                            value == widget.navigationShell.currentIndex,
                      );
                      setState(() {});
                    },
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Вопросы',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.list),
                        label: 'Опросы',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: 'Профиль',
                      ),
                    ],
                  ),
                )
              : null,
        ),
      ),
    );
  }

  bool showBottomNavigationBar() {
    final splitted = GoRouterState.of(context).uri.toString().split('/');
    if (splitted.isNotEmpty) {
      final last = splitted.last;
      switch (last) {
        case NavigationRoutes.welcomeForm ||
              NavigationRoutes.fillForm ||
              NavigationRoutes.endForm:
          return false;
      }
    }
    return true;
  }
}
