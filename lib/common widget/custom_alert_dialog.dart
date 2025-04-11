// // ignore_for_file: prefer_const_constructors
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
// import 'package:restaurent_discount_app/view/profile%20view/widget/custom_shadow_text_filed.dart';
//
// class CustomAlertDialog {
//   static void showCustomDialog({
//     required String title,
//     required String content,
//     required String cancelName,
//     required String actionName,
//     required String confirmText,
//     required VoidCallback onConfirm,
//     bool showPasswordField = false,
//     String? cancelText,
//     VoidCallback? onCancel,
//   }) {
//     Get.dialog(
//       Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.zero, // No border radius
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Stack(
//             children: [
//               Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(title,
//                       style: GoogleFonts.kumbhSans(
//                           fontWeight: FontWeight.bold, fontSize: 15.h)),
//                   SizedBox(height: 5.h),
//                   Text(content, style: GoogleFonts.kumbhSans(fontSize: 12.h)),
//                   SizedBox(height: 20),
//                   if (showPasswordField) ...[
//                     CustomShadowTextFiled(
//                         title: "Password",
//                         hintText: "Enter Password",
//                         showObscure: true),
//                     SizedBox(height: 30),
//                   ],
//                   Row(
//                     children: [
//                       SizedBox(
//                           height: 38.h,
//                           width: Get.width / 3.2,
//                           child: CustomButtonWidget(
//                               btnTextColor: Colors.white,
//                               btnText: actionName,
//                               onTap: onConfirm)),
//                       SizedBox(width: 10),
//                       SizedBox(
//                           height: 35.h,
//                           width: Get.width / 3.2,
//                           child: CustomButtonWidget(
//                               borderColor: Colors.grey,
//                               bgColor: Colors.transparent,
//                               btnTextColor: Colors.black,
//                               btnText: cancelName,
//                               onTap: onCancel ?? Get.back)),
//                     ],
//                   ),
//                 ],
//               ),
//               Positioned(
//                 top: 0,
//                 right: 0,
//                 child: GestureDetector(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: Icon(Icons.close, color: Colors.black),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       barrierDismissible: true,
//     );
//   }
// }
