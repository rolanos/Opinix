import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, BlocProvider;
import 'package:statistika_mobile/core/utils/extensions.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/routes.dart';
import 'cubit/admin_group_cubit.dart';
import 'widget/email_bottom_modal_sheet.dart';
import 'widget/role_bottom_modal_sheet.dart';

class AdminGroupScreen extends StatefulWidget {
  const AdminGroupScreen({
    super.key,
    this.surveyId,
  });

  final String? surveyId;

  @override
  State<AdminGroupScreen> createState() => _AdminGroupScreenState();
}

class _AdminGroupScreenState extends State<AdminGroupScreen> {
  final adminGroupCubit = AdminGroupCubit();

  @override
  void initState() {
    super.initState();
    adminGroupCubit.init(widget.surveyId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => adminGroupCubit,
      child: RefreshIndicator(
        notificationPredicate: (notification) {
          return notification.depth == 1;
        },
        onRefresh: () async => adminGroupCubit.update(),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              snap: false,
              pinned: true,
              floating: true,
              backgroundColor: AppColors.white,
              surfaceTintColor: AppColors.white,
              title: Text(
                'Административная группа',
                style: context.textTheme.bodyLarge
                    ?.copyWith(color: AppColors.black),
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    showEmailBottomSheet(
                      context,
                      onTap: (p0) => adminGroupCubit.add(p0),
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                  ),
                ),
              ],
            ),
          ],
          body: BlocBuilder<AdminGroupCubit, AdminGroupState>(
            bloc: adminGroupCubit,
            builder: (context, state) {
              if (state is AdminGroupInitial) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.adminGroups.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppConstants.smallPadding),
                  itemBuilder: (context, index) {
                    final data = state.adminGroups[index];
                    String? url;
                    if (data.user?.userInfo?.photo?.fullName != null) {
                      url =
                          "${ApiRoutes.getFile}${data.user!.userInfo!.photo!.fullName}";
                    }
                    return ListTile(
                      leading: url != null
                          ? CachedNetworkImage(
                              imageUrl: url,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: context.mediaQuerySize.width * 0.1,
                                width: context.mediaQuerySize.width * 0.1,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            )
                          : null,
                      title: Text(
                        data.user?.userInfo?.name ?? 'Нет имени',
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      subtitle: Text(
                        data.role?.name ?? 'Нет роли',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          await adminGroupCubit.deleteAdminGroup(data);
                        },
                        icon: const Icon(
                          Icons.delete,
                        ),
                      ),
                      onTap: () async {
                        await showRoleBottomSheet(
                          context,
                          onTap: (role) => adminGroupCubit.updateAdminGroup(
                            data,
                            role,
                          ),
                        );
                      },
                    );
                  },
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
