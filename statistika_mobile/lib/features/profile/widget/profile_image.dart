import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/utils/utils.dart';

import '../../../core/constants/constants.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    this.url,
    this.name,
    this.onTap,
  });

  final String? url;

  final String? name;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.mediumPadding),
        child: Column(
          spacing: AppConstants.mediumPadding,
          children: [
            (url != null)
                ? Builder(builder: (context) {
                    final size = context.mediaQuerySize.width * 0.25;
                    return CachedNetworkImage(
                      imageUrl: url!,
                      placeholder: (context, url) => SizedBox(
                        height: size,
                        width: size,
                      ),
                      fadeInDuration: AppConstants.animationChangeSizeDuration * 0.5,
                      fadeOutDuration: AppConstants.animationChangeSizeDuration * 0.5,
                      imageBuilder: (context, imageProvider) => Container(
                        height: size,
                        width: size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  })
                : Center(
                    child: Container(
                      height: context.mediaQuerySize.width * 0.25,
                      width: context.mediaQuerySize.width * 0.25,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 214, 215, 228),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.photo_camera,
                        ),
                      ),
                    ),
                  ),
            if (name != null)
              Text(
                name!,
                textAlign: TextAlign.center,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
