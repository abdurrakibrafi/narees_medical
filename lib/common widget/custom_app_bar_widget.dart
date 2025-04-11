import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double? fontSize;
  final VoidCallback? onTap;
  final bool centerTitle;
  final Color? backgroundColor;
  final bool forceMaterialTransparency;
  final bool? automaticallyImplyLeading;
  final List<Widget>? actions;
  final Widget? leading;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.fontSize,
    this.centerTitle = true,
    this.backgroundColor = Colors.transparent,
    this.forceMaterialTransparency = true,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading,
    this.onTap,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      backgroundColor: backgroundColor,
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: fontSize ?? 17.h,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: centerTitle,
      actions: actions,
      leading: leading ??
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: onTap ??
                    () {
                  if (Get.isSnackbarOpen) {
                    Get.closeCurrentSnackbar();
                  }
                  if (Navigator.canPop(context)) {
                   Navigator.pop(context);
                  } else {
                    if (kDebugMode) {
                      print("No routes to pop");
                    }
                  }
                },
          ),

      elevation: forceMaterialTransparency ? 0 : null,
    );
  }
}
