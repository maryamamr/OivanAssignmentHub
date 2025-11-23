import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oivan_assignment/core/constants/app_colors.dart';
import 'package:oivan_assignment/core/constants/style.dart';
import 'package:oivan_assignment/core/constants/ui_const.dart';
import 'package:oivan_assignment/shared_widgets/stateless/custom_text.dart';
import '../../data/models/user_model.dart';

class UserItemWidget extends StatelessWidget {
  final UserModel user;
  final VoidCallback? onTap;
  final VoidCallback onBookmarkToggle;

  const UserItemWidget({
    super.key,
    required this.user,
    this.onTap,
    required this.onBookmarkToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: UIConst.horizontalPadding)
          .copyWith(bottom: UIConst.verticalPadding),
      shape: AppStyle.cardStyle,
      color: Colors.white,
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primaryColor,
              width: .5,
            ),
          ),
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(user.profileImage),
          ),
        ),
        title: CustomText(user.displayName),
        subtitle: CustomText(user.location),
        trailing: IconButton(
          alignment: AlignmentDirectional.topEnd,
          padding: EdgeInsets.zero,
          icon: Icon(
            user.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            color: user.isBookmarked ? Colors.amber : null,
          ),
          onPressed: onBookmarkToggle,
        ),
        onTap: onTap,
      ),
    );
  }
}
