import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oivan_assignment/core/constants/app_colors.dart';
import 'package:oivan_assignment/main.dart';
import 'package:oivan_assignment/shared_widgets/stateless/custom_text.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
    String? title,
    double super.leadingWidth = 45.0,
    String? svgIcon,
    Color? backgroundColor,
    Color? iconColor,
    Color? titleColor,
    super.actions,
    SystemUiOverlayStyle? systemUiOverlayStyle,
    bool? centerTitle,
    super.automaticallyImplyLeading,
    void Function()? onTap,
  }) : super(
          title: title != null
              ? CustomText(
                  title,
                  style: TextStyle(color: titleColor ?? Colors.white),
                  textAlign:
                      centerTitle == false ? TextAlign.start : TextAlign.center,
                )
              : null,
          elevation: 1,
          iconTheme: IconThemeData(color: iconColor ?? Colors.white),
          centerTitle: centerTitle ?? true,
          backgroundColor: backgroundColor ?? AppColors.primaryColor,
          systemOverlayStyle: systemUiOverlayStyle ??
              Theme.of(
                navigatorKey.currentContext!,
              ).appBarTheme.systemOverlayStyle,
        );
}
