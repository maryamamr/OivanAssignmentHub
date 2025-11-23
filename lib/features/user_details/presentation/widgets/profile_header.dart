import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oivan_assignment/core/constants/app_colors.dart';
import 'package:oivan_assignment/core/utils/profile_header_painter.dart';
import 'package:oivan_assignment/features/user_list/data/models/user_model.dart';
import 'package:oivan_assignment/shared_widgets/stateless/custom_network_image.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel user;
  const ProfileHeader(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final height = screenSize.height / 2.2;
    final width = screenSize.width;
    final mobileHeight = 200.h;

    return SizedBox(
      height: mobileHeight,
      width: width,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              painter: ProfileHeaderPainter(
                backGroundColor: AppColors.primaryColor,
                borderColor: AppColors.primaryColor,
                borderWidth: 2.4,
              ),
              size: Size(width, height / 2),
            ),
          ),
          Positioned(
              top: 40.h,
              left: 10.w,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.white,
              )),
          Positioned(
              bottom: 5.h,
              left: 0,
              right: 0,
              child: _buildUserImage(context, user.profileImage)),
        ],
      ),
    );
  }

  Widget _buildUserImage(BuildContext context, String? userImage) {
    final size = 70.h;

    return Center(
      child: SizedBox(
        width: size + 15,
        height: size + 15,
        child: CircleAvatar(
          radius: size / 1.75,
          backgroundColor: AppColors.secondaryColor,
          child: CustomCachedNetworkImage(
            imageUrl: userImage ?? '',
            height: size + 9,
            width: size + 9,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(size),
          ),
        ),
      ),
    );
  }
}
