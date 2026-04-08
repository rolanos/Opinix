import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/core/widgets/custom_container.dart';

class ProfileSection {
  ProfileSection({
    required this.name,
    required this.onTap,
    this.iconPath,
  });

  final String name;
  final String? iconPath;

  final void Function() onTap;
}

class ProfileSections extends StatelessWidget {
  const ProfileSections({
    super.key,
    this.sections = const [],
  });

  final List<ProfileSection> sections;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomContainer(
        margin: const EdgeInsets.symmetric(
          horizontal: AppConstants.miniPadding,
        ),
        padding: const EdgeInsets.all(
          AppConstants.miniPadding / 2,
        ),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sections.length,
          separatorBuilder: (context, index) => const Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppConstants.mediumPadding),
            child: Divider(
              height: 0,
            ),
          ),
          itemBuilder: (context, index) => Material(
            child: ListTile(
              onTap: sections[index].onTap,
              title: Text(
                sections[index].name,
                style: context.textTheme.bodyMedium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
