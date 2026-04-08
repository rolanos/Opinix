import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/core/enum/gender.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/core/widgets/custom_container.dart';
import 'package:statistika_mobile/core/widgets/dialog.dart';
import 'package:statistika_mobile/features/authorization/view/cubit/authorization_cubit.dart';
import 'package:statistika_mobile/features/form/view/forms/cubit/forms_tab_cubit.dart';
import 'package:statistika_mobile/features/profile/cubit/user_profile_cubit.dart';

import '../../core/constants/routes.dart';
import '../../core/widgets/button_widget.dart';
import '../../core/widgets/custom_sliver_app_bar.dart';
import 'widget/non_auth_widget.dart';
import 'widget/profile_image.dart';
import 'widget/profile_info_container.dart';
import 'widget/profile_sections.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Gender? genderValue;

  DateTime? birthday;

  final nameController = TextEditingController();

  final nameFocusNode = FocusNode();

  final imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final state = context.read<UserProfileCubit>().state;
    nameController.addListener(() => setState(() {}));
    if (state is UserProfileInitial) {
      nameController.text = state.user.userInfo?.name ?? '';
      birthday = state.user.userInfo?.birthday;
      switch (state.user.userInfo?.isMan) {
        case true:
          genderValue = Gender.male;
        case false:
          genderValue = Gender.female;
        default:
      }
    } else {
      if (context.mounted) {
        context.read<UserProfileCubit>().initById();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileCubit, UserProfileState>(
      listener: (context, state) {
        if (state is UserProfileInitial) {
          birthday = state.user.userInfo?.birthday;
          switch (state.user.userInfo?.isMan) {
            case true:
              genderValue = Gender.male;
            case false:
              genderValue = Gender.female;
            default:
          }
        }
      },
      builder: (context, userState) {
        String? url;
        if (userState is UserProfileInitial &&
            userState.user.userInfo?.photo?.fullName != null) {
          url =
              "${ApiRoutes.getFile}${userState.user.userInfo!.photo!.fullName}";
        }

        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: context.mediaQuerySize.height * 0.75,
          ),
          child: Center(
            child: RefreshIndicator(
              onRefresh: () async => context.read<UserProfileCubit>().update(),
              child: CustomScrollView(
                slivers: [
                  const CustomSliverAppBar(
                    titleText: 'Профиль',
                  ),
                  if (userState is! UserProfileAnonymous)
                    SliverToBoxAdapter(
                      child: Align(
                        alignment: AlignmentGeometry.center,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: AppConstants.mediumPadding),
                          child: Column(
                            spacing: AppConstants.mediumPadding,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (userState is! UserProfileAnonymous)
                                CustomContainer(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      AppConstants.mediumPadding,
                                    ),
                                  ),
                                  margin: const EdgeInsets.only(
                                    top: AppConstants.smallPadding,
                                  ),
                                  child: ProfileImage(
                                    url: url,
                                    name: userState.user?.username,
                                    onTap: () async {
                                      final pickedImage =
                                          await imagePicker.pickImage(
                                        source: ImageSource.gallery,
                                      );
                                      if (pickedImage != null &&
                                          context.mounted) {
                                        await context
                                            .read<UserProfileCubit>()
                                            .updateProfilePhoto(
                                              pickedImage,
                                            );
                                      }
                                    },
                                  ),
                                ),
                              if (userState is UserProfileInitial)
                                ProfileInfoContainer(
                                  user: userState.user,
                                ),
                              if (userState is UserProfileInitial)
                                ProfileSections(
                                  sections: [
                                    ProfileSection(
                                      name: 'Мои вопросы',
                                      onTap: () {
                                        context.goNamed(NavigationRoutes
                                            .myGeneralQuestions);
                                      },
                                    ),
                                    ProfileSection(
                                      name: 'Мои опросы',
                                      onTap: () {
                                        context.goNamed(
                                          NavigationRoutes.forms,
                                        );
                                        context
                                            .read<FormsTabCubit>()
                                            .state
                                            .controller
                                            ?.animateTo(1);
                                      },
                                    ),
                                    if (userState.isModerator)
                                      ProfileSection(
                                        name: 'Модерация вопросов',
                                        onTap: () {
                                          context.pushNamed(
                                            NavigationRoutes
                                                .moderateGeneralQuestionScreen,
                                          );
                                        },
                                      ),
                                  ],
                                ),
                              Align(
                                child: BlocBuilder<AuthorizationCubit,
                                    AuthorizationState>(
                                  builder: (context, state) {
                                    return Padding(
                                      padding:
                                          const EdgeInsetsGeometry.symmetric(
                                        horizontal: AppConstants.mediumPadding,
                                      ),
                                      child: ButtonWidget(
                                        onPressed: () async {
                                          if (userState
                                              is! UserProfileLoading) {
                                            final result =
                                                await showCustomDialog(
                                              context,
                                              'Выход',
                                              'Вы уверены, что хотите выйти из Opinix?',
                                            );
                                            if (result && context.mounted) {
                                              await context
                                                  .read<AuthorizationCubit>()
                                                  .logout();
                                            }
                                          }
                                        },
                                        text: 'Выйти',
                                        backgroundColor: AppColors.red,
                                        isLoading:
                                            state is AuthorizationLoading,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    const NonAuthWidget(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
