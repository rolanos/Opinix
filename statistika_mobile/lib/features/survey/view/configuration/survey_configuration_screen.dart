import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/core/widgets/button_widget.dart';

import 'cubit/survey_configuration_cubit.dart';

class SurveyConfigurationScreen extends StatefulWidget {
  const SurveyConfigurationScreen({super.key, this.surveyId});

  final String? surveyId;

  @override
  _SurveyConfigurationScreenState createState() =>
      _SurveyConfigurationScreenState();
}

class _SurveyConfigurationScreenState extends State<SurveyConfigurationScreen> {
  bool isAnonymous = false;
  DateTime? startDate;
  DateTime? endDate;

  final surveyConfigurationCubit = SurveyConfigurationCubit();

  @override
  void initState() {
    super.initState();
    surveyConfigurationCubit.init(widget.surveyId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => surveyConfigurationCubit,
      child: RefreshIndicator(
        notificationPredicate: (notification) {
          return notification.depth == 2;
        },
        onRefresh: () async => surveyConfigurationCubit.update(),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              snap: false,
              pinned: true,
              floating: true,
              backgroundColor: AppColors.white,
              surfaceTintColor: AppColors.white,
              title: Text(
                'Конфигурация опроса',
                style: context.textTheme.bodyLarge
                    ?.copyWith(color: AppColors.black),
              ),
            ),
          ],
          body: BlocBuilder<SurveyConfigurationCubit, SurveyConfigurationState>(
            bloc: surveyConfigurationCubit,
            builder: (context, state) {
              if (state is SurveyConfigurationInitial) {
                isAnonymous = state.surveyConfiguration.isAnonymous;
                startDate = state.surveyConfiguration.startDate;
                endDate = state.surveyConfiguration.endDate;
              }
              return Center(
                child: Container(
                  margin: const EdgeInsets.all(AppConstants.mediumPadding),
                  padding: const EdgeInsets.all(AppConstants.mediumPadding),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: AppTheme.shadow,
                    borderRadius: BorderRadius.circular(
                      AppConstants.mediumPadding,
                    ),
                  ),
                  child: Column(
                    spacing: AppConstants.mediumPadding,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SwitchListTile(
                        title: Text(
                          'Анонимный',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                        value: isAnonymous,
                        onChanged: (bool value) {
                          surveyConfigurationCubit.updateConfiguration(
                            isAnonymous: value,
                          );
                        },
                      ),
                      ButtonWidget(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                            builder: (context, child) {
                              return child!;
                            },
                          );
                          if (picked != null) {
                            surveyConfigurationCubit.updateConfiguration(
                              startDate: picked,
                            );
                          }
                        },
                        text: startDate == null
                              ? 'Выбрать дату начала'
                              : 'Начало: ${startDate?.toFormattedString()}',
                      ),
                      ButtonWidget(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                            builder: (context, child) {
                              return child!;
                            },
                          );
                          if (picked != null) {
                            surveyConfigurationCubit.updateConfiguration(
                              endDate: picked,
                            );
                          }
                        },
                        text: endDate == null
                            ? 'Выбрать дату окончания'
                            : 'Окончание: ${endDate?.toFormattedString()}',
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 32),
                        ),
                        onPressed: () {
                          context.goNamed(
                            NavigationRoutes.surveyAdminGroup,
                            queryParameters: {'surveyId': widget.surveyId},
                          );
                        },
                        child: Text(
                          'Просмотр админ. группы',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
