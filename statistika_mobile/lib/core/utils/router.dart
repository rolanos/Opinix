import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/utils/shared_preferences_manager.dart';
import 'package:statistika_mobile/core/widgets/snack_bar.dart';
import 'package:statistika_mobile/features/authorization/view/authorization_screen.dart';
import 'package:statistika_mobile/features/authorization/view/email_code_accept.dart';
import 'package:statistika_mobile/features/moderation/moderation_screen.dart';
import 'package:statistika_mobile/features/profile/profile_screen.dart';
import 'package:statistika_mobile/features/form/view/create_form/create_form_screen.dart';
import 'package:statistika_mobile/features/form/view/fill_form/cubit/fill_form/fill_form_cubit.dart';
import 'package:statistika_mobile/features/form/view/fill_form/end_form_screen.dart';
import 'package:statistika_mobile/features/form/view/fill_form/fill_form_screen.dart';
import 'package:statistika_mobile/features/form/view/form_analitic/form_analitic_screen.dart';
import 'package:statistika_mobile/features/form/view/form_editer/form_editer_screen.dart';
import 'package:statistika_mobile/features/form/view/forms/forms_screen.dart';
import 'package:statistika_mobile/features/form/view/fill_form/welcome_form_screen.dart';
import 'package:statistika_mobile/features/general_question/view/create_question_screen.dart';
import 'package:statistika_mobile/features/general_question/view/general_question_screen.dart';
import 'package:statistika_mobile/features/home/home_screen.dart';
import 'package:statistika_mobile/features/survey/view/admin_group/admin_group_screen.dart';

import '../../features/authorization/view/register_screen.dart';
import '../../features/authorization/view/welcome_screen.dart';
import '../../features/history_general_questions/history_general_questions_screen.dart';
import '../../features/my_general_questions/my_general_questions_screen.dart';
import '../../features/my_general_questions/question_screen.dart';
import '../../features/profile/cubit/user_profile_cubit.dart';
import '../../features/survey/view/configuration/survey_configuration_screen.dart';

GoRouter get router {
  return GoRouter(
    initialLocation: '/${NavigationRoutes.welcome}',
    routes: [
      GoRoute(
        path: '/${NavigationRoutes.confirmEmail}',
        name: NavigationRoutes.confirmEmail,
        pageBuilder: (context, state) => buildSlideTransitionPage(
          const EmailCodeAccept(),
        ),
      ),
      GoRoute(
        path: '/${NavigationRoutes.welcome}',
        name: NavigationRoutes.welcome,
        redirect: (context, state) async {
          final userId = await SharedPreferencesManager.getUserId();
          final isAnonimous = await SharedPreferencesManager.getAnonymous();
          if (userId != null || isAnonimous) {
            return '/${NavigationRoutes.generalQuestions}';
          }
          return null;
        },
        pageBuilder: (context, state) => buildSlideTransitionPage(
          const WelcomeScreen(),
        ),
        routes: [
          GoRoute(
            path: NavigationRoutes.auth,
            name: NavigationRoutes.auth,
            pageBuilder: (context, state) => buildSlideTransitionPage(
              const AuthorizationScreen(),
            ),
            routes: [
              GoRoute(
                path: NavigationRoutes.register,
                name: NavigationRoutes.register,
                pageBuilder: (context, state) => buildSlideTransitionPage(
                  const RegisterScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) =>
            buildSlideTransitionPage(
          HomeScreen(navigationShell: navigationShell),
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${NavigationRoutes.generalQuestions}',
                name: NavigationRoutes.generalQuestions,
                pageBuilder: (context, state) => buildSlideTransitionPage(
                  const GeneralQuestionScreen(),
                ),
                routes: [
                  GoRoute(
                    path: NavigationRoutes.createGeneralQuestion,
                    name: NavigationRoutes.createGeneralQuestion,
                    pageBuilder: (context, state) => buildSlideTransitionPage(
                      CreateQuestionScreen(
                        type: state.uri.queryParameters['type'],
                      ),
                    ),
                    redirect: (context, state) async {
                      final state = context.read<UserProfileCubit>().state;
                      final checkAnonymous =
                          await SharedPreferencesManager.getAnonymous();
                      if ((state is UserProfileAnonymous || checkAnonymous) &&
                          context.mounted) {
                        showCustomSnackBar(
                          context,
                          'Необходимо авторизоваться',
                        );
                        return '/${NavigationRoutes.profile}';
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${NavigationRoutes.forms}',
                name: NavigationRoutes.forms,
                pageBuilder: (context, state) => buildSlideTransitionPage(
                  const FormsScreen(),
                ),
                routes: [
                  GoRoute(
                    path: NavigationRoutes.surveyConfiguration,
                    name: NavigationRoutes.surveyConfiguration,
                    pageBuilder: (context, state) => buildSlideTransitionPage(
                      SurveyConfigurationScreen(
                        surveyId: state.uri.queryParameters['surveyId'],
                      ),
                    ),
                    routes: [
                      GoRoute(
                        path: NavigationRoutes.surveyAdminGroup,
                        name: NavigationRoutes.surveyAdminGroup,
                        pageBuilder: (context, state) =>
                            buildSlideTransitionPage(
                          AdminGroupScreen(
                            surveyId: state.uri.queryParameters['surveyId'],
                          ),
                        ),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: NavigationRoutes.formAnalitic,
                    name: NavigationRoutes.formAnalitic,
                    pageBuilder: (context, state) => buildSlideTransitionPage(
                      FormAnaliticScreen(
                        formId: state.uri.queryParameters['formId'],
                      ),
                    ),
                  ),
                  GoRoute(
                    path: NavigationRoutes.createForm,
                    name: NavigationRoutes.createForm,
                    pageBuilder: (context, state) => buildSlideTransitionPage(
                      const CreateFormScreen(),
                    ),
                  ),
                  GoRoute(
                    path: NavigationRoutes.formEditer,
                    name: NavigationRoutes.formEditer,
                    pageBuilder: (context, state) => buildSlideTransitionPage(
                      FormEditerScreen(
                        formId: state.uri.queryParameters['formId'],
                      ),
                    ),
                  ),
                  GoRoute(
                    path: NavigationRoutes.welcomeForm,
                    name: NavigationRoutes.welcomeForm,
                    pageBuilder: (context, state) => buildSlideTransitionPage(
                      const WelcomeFormScreen(),
                    ),
                  ),
                  GoRoute(
                    path: NavigationRoutes.fillForm,
                    name: NavigationRoutes.fillForm,
                    pageBuilder: (context, state) => buildSlideTransitionPage(
                      BlocProvider.value(
                        value: state.extra as FillFormCubit,
                        child: const FillFormScreen(),
                      ),
                    ),
                  ),
                  GoRoute(
                    path: NavigationRoutes.endForm,
                    name: NavigationRoutes.endForm,
                    pageBuilder: (context, state) => buildSlideTransitionPage(
                      const EndFormScreen(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${NavigationRoutes.profile}',
                name: NavigationRoutes.profile,
                pageBuilder: (context, state) => buildSlideTransitionPage(
                  const ProfileScreen(),
                ),
                routes: [
                  GoRoute(
                    path: NavigationRoutes.questionScreen,
                    name: NavigationRoutes.questionScreen,
                    pageBuilder: (context, state) => buildSlideTransitionPage(
                      const QuestionScreen(),
                    ),
                  ),
                  GoRoute(
                    path: NavigationRoutes.myGeneralQuestions,
                    name: NavigationRoutes.myGeneralQuestions,
                    pageBuilder: (context, state) => buildSlideTransitionPage(
                      const MyGeneralQuestionsScreen(),
                    ),
                  ),
                  GoRoute(
                    path: NavigationRoutes.historyGeneralQuestions,
                    name: NavigationRoutes.historyGeneralQuestions,
                    pageBuilder: (context, state) => buildSlideTransitionPage(
                      const HistoryGeneralQuestionsScreen(),
                    ),
                  ),
                  GoRoute(
                    path: NavigationRoutes.moderateGeneralQuestionScreen,
                    name: NavigationRoutes.moderateGeneralQuestionScreen,
                    pageBuilder: (context, state) => buildSlideTransitionPage(
                      const ModerationScreen(),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

Future<String?> redirectToAuthorization() async {
  final userId = await SharedPreferencesManager.getUserId();
  if (userId == null) {
    return '/${NavigationRoutes.welcome}/${NavigationRoutes.auth}';
  }
  return null;
}

CustomTransitionPage buildSlideTransitionPage(Widget child) {
  return CustomTransitionPage(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1, 0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      final tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
    transitionDuration: const Duration(milliseconds: 225),
  );
}

Future<void> setOptimalDisplayMode() async {
  final List<DisplayMode> supported = await FlutterDisplayMode.supported;
  final DisplayMode active = await FlutterDisplayMode.active;

  final List<DisplayMode> sameResolution = supported
      .where((DisplayMode m) =>
          m.width == active.width && m.height == active.height)
      .toList()
    ..sort((DisplayMode a, DisplayMode b) =>
        b.refreshRate.compareTo(a.refreshRate));

  final DisplayMode mostOptimalMode =
      sameResolution.isNotEmpty ? sameResolution.first : active;

  /// This setting is per session.
  /// Please ensure this was placed with `initState` of your root widget.
  await FlutterDisplayMode.setPreferredMode(mostOptimalMode);
}
