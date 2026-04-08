import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.errorMessage,
    this.onRefresh,
  });

  final String errorMessage;
  final void Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: AppConstants.smallPadding,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(errorMessage),
          IconButton(
            onPressed: onRefresh,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
    ;
  }
}
