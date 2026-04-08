import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/utils/utils.dart';
import 'package:statistika_mobile/core/widgets/button_widget.dart';
import 'package:statistika_mobile/features/form/view/forms/cubit/forms_cubit.dart';
import 'package:statistika_mobile/features/form/view/forms/cubit/my_forms_cubit.dart';

import '../../../../core/widgets/custom_sliver_app_bar.dart';
import '../../../../core/widgets/error_widget.dart';
import 'cubit/forms_tab_cubit.dart';
import 'widget/form_card.dart';

class FormsScreen extends StatefulWidget {
  const FormsScreen({
    super.key,
  });

  @override
  State<FormsScreen> createState() => _FormsScreenState();
}

class _FormsScreenState extends State<FormsScreen>
    with SingleTickerProviderStateMixin {
  final allFormsCubit = AllFormsCubit();
  final myFormsCubit = MyFormsCubit();

  @override
  void initState() {
    super.initState();
    context.read<FormsTabCubit>().init(
          TabController(
            length: 2,
            vsync: this,
          ),
        );
    allFormsCubit.getForms();
    myFormsCubit.getForms();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormsTabCubit, FormsTabState>(
      builder: (context, tab) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => allFormsCubit,
            ),
            BlocProvider(
              create: (context) => myFormsCubit,
            ),
          ],
          child: RefreshIndicator(
            notificationPredicate: (notification) {
              return notification.depth == 2;
            },
            onRefresh: () async {
              await allFormsCubit.getForms();
              await myFormsCubit.getForms();
            },
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: CustomSliverAppBar(
                    titleText: 'Опросы',
                    actions: [
                      IconButton(
                        onPressed: () {
                          context.goNamed(NavigationRoutes.createForm);
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                    bottom: TabBar(
                      controller: tab.controller,
                      dividerColor: AppColors.divider,
                      labelStyle: context.textTheme.titleSmall,
                      tabs: const [
                        Tab(
                          text: 'Все опросы',
                        ),
                        Tab(
                          text: 'Мои опросы',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              body: Builder(builder: (context) {
                return TabBarView(
                  controller: tab.controller,
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: BlocBuilder<AllFormsCubit, AllFormsState>(
                            builder: (context, state) {
                              if (state is AllFormsLoading) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        AppConstants.mediumPadding),
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              if (state is AllFormsInitial) {
                                return ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: state.forms.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(
                                    AppConstants.mediumPadding,
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                          height: AppConstants.mediumPadding),
                                  itemBuilder: (context, index) => FormCard(
                                    form: state.forms[index],
                                  ),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                      ],
                    ),
                    CustomScrollView(
                      slivers: [
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverToBoxAdapter(
                          child: BlocBuilder<MyFormsCubit, MyFormsState>(
                            builder: (context, state) {
                              if (state is MyFormsError) {
                                return CustomErrorWidget(
                                  errorMessage: state.message,
                                  onRefresh: () async {
                                    await myFormsCubit.getForms();
                                  },
                                );
                              }
                              if (state is MyFormsLoading) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        AppConstants.mediumPadding),
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              if (state is MyFormsInitial) {
                                if (state.forms.isEmpty) {
                                  return Padding(
                                    padding: const EdgeInsets.all(
                                      AppConstants.mediumPadding,
                                    ),
                                    child: Column(
                                      spacing: AppConstants.smallPadding,
                                      children: [
                                        Text(
                                          'Вы ещё не проходили опросы. Самое время начать!',
                                          style: context.textTheme.bodyLarge,
                                        ),
                                        ButtonWidget(
                                          onPressed: () {
                                            tab.controller?.animateTo(0);
                                          },
                                          text: 'Перейти к опросам',
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: state.forms.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppConstants.mediumPadding,
                                    vertical: AppConstants.mediumPadding,
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                          height: AppConstants.mediumPadding),
                                  itemBuilder: (context, index) => FormCard(
                                    form: state.forms[index],
                                    mode: FormCardViewMode.admin,
                                  ),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
