import 'package:flutter/foundation.dart';

abstract class ApiRoutes {
  static const baseUrl = kDebugMode ? 'http://10.0.2.2:80' : 'https://opinix.ru/api';

  static const privacyUrl = 'https://opinix.ru/privacy';
  static const termsUrl = 'https://opinix.ru/terms';

  static const register = '$baseUrl/auth/register';
  static const login = '$baseUrl/auth/login';
  static const confirmEmail = '$baseUrl/auth/confirm_email';
  static const refreshToken = '$baseUrl/auth/refresh-token';
  static const checkModerate = '$baseUrl/auth/check-moderate';
  static const logout = '$baseUrl/auth/logout';

  static const users = '$baseUrl/users';

  static const userInfo = '$baseUrl/user_infos';

  static const surveys = '$baseUrl/surveys';

  static const sections = '$baseUrl/sections';

  static const forms = '$baseUrl/forms';

  static const formsByFormId = '$forms/formId';

  static const formsByUserId = '$forms/userId';

  static const answers = '$baseUrl/answers';

  static const availableAnswer = '$baseUrl/avaliable_answers';

  static const answersForForm = '$answers/form';

  static const questions = '$baseUrl/questions';

  static const _generalQuestion = '$questions/general';

  static const nextGeneralQuestion = '$_generalQuestion/next';

  static const myGeneralQuestion = '$_generalQuestion/my';

  static const historyGeneralQuestion = '$_generalQuestion/history';

  static const nextToModerateGeneralQuestion =
      '$_generalQuestion/next-to-moderate';

  static const confirmModerateGeneralQuestion =
      '$_generalQuestion/confirm-moderate';

  static const analitical = '$baseUrl/analitical';

  static const surveyConfiguration = '$baseUrl/survey_configurations';

  static const adminGroup = '$baseUrl/admin_groups';

  static const classifier = '$baseUrl/classifiers';

  static const questionTypes = '$classifier/question_types';

  static const surveyRoles = '$classifier/survey_roles';

  static const surveyTypes = '$classifier/survey_types';

  static const files = '$baseUrl/files';

  static const getFile = '$files?name=';
}

abstract class NavigationRoutes {
  static const welcome = 'welcome';
  static const auth = 'auth';
  static const register = 'register';
  static const confirmEmail = 'confirm_email';

  static const generalQuestions = 'general_questions';
  static const createGeneralQuestion = 'create_general_question';

  static const surveys = 'surveys';
  static const forms = 'forms';
  static const createForm = 'create_form';
  static const formEditer = 'form_editer_screen';
  static const formAnalitic = 'form_analitic';
  static const surveyConfiguration = 'configuration';
  static const surveyAdminGroup = 'admin_group';

  static const welcomeForm = 'welcome_form';
  static const fillForm = 'fill_form';
  static const endForm = 'end_form';

  static const profile = 'profile';
  static const myGeneralQuestions = 'my_general_questions';
  static const questionScreen = 'question_screen';
  static const historyGeneralQuestions = 'history_general_questions';
  static const moderateGeneralQuestionScreen =
      'moderate_general_question_screen';
}
