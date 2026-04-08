import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/core/enum/gender.dart';
import 'package:statistika_mobile/core/utils/utils.dart';
import 'package:statistika_mobile/core/widgets/custom_container.dart';

import '../../../core/widgets/select_modal_sheet.dart';
import '../../authorization/domain/model/user.dart';
import '../cubit/user_profile_cubit.dart';

class ProfileInfoContainer extends StatefulWidget {
  const ProfileInfoContainer({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<ProfileInfoContainer> createState() => _ProfileInfoContainerState();
}

class _ProfileInfoContainerState extends State<ProfileInfoContainer> {
  Gender? gender;

  @override
  void initState() {
    super.initState();
    gender = Gender.tryParse(widget.user.userInfo?.isMan);
  }

  @override
  void didUpdateWidget(covariant ProfileInfoContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    gender = Gender.tryParse(widget.user.userInfo?.isMan);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    gender = Gender.tryParse(widget.user.userInfo?.isMan);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomContainer(
        margin: const EdgeInsets.symmetric(
          horizontal: AppConstants.miniPadding,
        ),
        child: Column(
          spacing: AppConstants.smallPadding,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Информация профиля',
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: SvgPicture.asset(IconRoutes.email),
              title: SelectableText(
                widget.user.email,
                style: context.textTheme.bodyMedium,
              ),
              contentPadding: EdgeInsets.zero,
            ),
            const Divider(height: 0),
            ListTile(
              onTap: () async {
                Gender? gender;
                await showSelectionModal<Gender>(
                  context,
                  Gender.values,
                  title: 'Укажите пол',
                  onTap: (newGender) => gender = newGender,
                );
                if (context.mounted && gender != null) {
                  await context.read<UserProfileCubit>().updateUserProfileInfo(
                        null,
                        gender,
                        widget.user.userInfo?.birthday,
                      );
                }
              },
              leading: SvgPicture.asset(IconRoutes.genderMale),
              title: Text(
                gender?.name ?? 'Укажите пол',
                style: context.textTheme.bodyMedium,
              ),
              contentPadding: EdgeInsets.zero,
            ),
            const Divider(height: 0),
            ListTile(
              onTap: () async {
                final birthDay = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1920),
                  lastDate: DateTime(2014),
                  initialEntryMode: DatePickerEntryMode.input,
                );
                if (context.mounted && birthDay != null) {
                  await context.read<UserProfileCubit>().updateUserProfileInfo(
                        null,
                        Gender.tryParse(widget.user.userInfo?.isMan),
                        birthDay,
                      );
                }
              },
              leading: SvgPicture.asset(IconRoutes.birthday),
              title: Text(
                widget.user.userInfo?.birthday?.toFormattedString() ??
                    'Укажите возраст',
                style: context.textTheme.bodyMedium,
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }
}
