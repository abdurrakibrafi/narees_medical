// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:restaurent_discount_app/common%20widget/custom_alert_dialog.dart';
// import 'package:restaurent_discount_app/common%20widget/custom_drawer_card_widget.dart';
// import 'package:restaurent_discount_app/uitilies/app_colors.dart';
// import 'package:restaurent_discount_app/uitilies/app_images.dart';
// import 'package:restaurent_discount_app/view/add%20restaurent%20view/add_restaurent_view.dart';
// import 'package:restaurent_discount_app/view/auth%20view/sign%20in%20view/sign_in_view.dart';
// import 'package:restaurent_discount_app/view/montly%20check%20in%20view/montly_check_in_view.dart';
// import 'package:restaurent_discount_app/view/offer%20view/exclusive_discount_offer_view.dart';
// import 'package:restaurent_discount_app/view/review%20view/user_review_view.dart';
// import 'package:restaurent_discount_app/view/settings%20view/settings_view.dart';
// import 'package:restaurent_discount_app/view/statistics%20view%20and%20ratio/statistics_view.dart';
// import 'package:restaurent_discount_app/view/subscriptions%20view/subscriptions_view.dart';
//
// class CustomDrawerForVendor extends StatelessWidget {
//   const CustomDrawerForVendor({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(0.0.h, 50.h, 0, 0),
//       child: Drawer(
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topRight: Radius.circular(10),
//             bottomRight: Radius.circular(0),
//           ),
//         ),
//         width: Get.width / 1.3,
//         backgroundColor: AppColors.bgColor,
//         child: Stack(
//           children: [
//             ListView(
//               children: <Widget>[
//                 SizedBox(height: 10.h),
//                 Row(
//                   children: [
//                     SizedBox(width: 10.h),
//                     Container(
//                       width: 50.0.h,
//                       height: 50.0.h,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: AppColors.mainColor,
//                           width: 2.0.w,
//                         ),
//                       ),
//                       child: ClipOval(
//                         child: Image.asset(
//                           AppImages.profileImage,
//                           fit: BoxFit.cover,
//                           width: 50.0.h,
//                           height: 50.0.h,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 4.h),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Benjamin Parker",
//                           style: GoogleFonts.kumbhSans(
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           "Benjamin45@gmail.com",
//                           style: GoogleFonts.kumbhSans(fontSize: 10),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//                 SizedBox(height: 10.h),
//                 Container(
//                   color: AppColors.mainColor,
//                   height: 0.5.h,
//                   width: Get.width,
//                 ),
//                 SizedBox(height: 15.h),
//                 CustomDrawerCardWidget(
//                   cardName: 'Home',
//                   cardIcon: Icons.home_outlined,
//                   onTap: () {},
//                 ),
//                 SizedBox(height: 15.h),
//                 CustomDrawerCardWidget(
//                   cardName: 'Your Profile',
//                   cardIcon: Icons.person_2_outlined,
//                   onTap: () {},
//                 ),
//                 SizedBox(height: 15.h),
//                 CustomDrawerCardWidget(
//                   cardName: 'Add Restaurent',
//                   cardIcon: Icons.restaurant,
//                   onTap: () {
//                     Get.to(() => AddRestaurentView());
//                   },
//                 ),
//                 SizedBox(height: 15.h),
//                 CustomDrawerCardWidget(
//                   cardName: 'Offers Now',
//                   cardIcon: Icons.local_offer_outlined,
//                   onTap: () {
//                     Get.to(() => ExclusivesOfferesView());
//                   },
//                 ),
//                 SizedBox(height: 15.h),
//                 CustomDrawerCardWidget(
//                   cardName: 'Current Review',
//                   cardIcon: Icons.mark_unread_chat_alt_outlined,
//                   onTap: () {
//                     Get.to(() => UserReviewView());
//                   },
//                 ),
//                 SizedBox(height: 15.h),
//                 CustomDrawerCardWidget(
//                   cardName: 'Statistics & Income Ratio',
//                   cardIcon: Icons.bar_chart,
//                   onTap: () {
//                     Get.to(() => StatisticsView());
//                   },
//                 ),
//                 SizedBox(height: 15.h),
//                 CustomDrawerCardWidget(
//                   cardName: 'Monthly Check-ins ',
//                   cardIcon: Icons.check_circle_outline,
//                   onTap: () {
//                     Get.to(() => MontlyCheckInView());
//                   },
//                 ),
//                 SizedBox(height: 15.h),
//                 CustomDrawerCardWidget(
//                   cardName: 'Settings',
//                   cardIcon: Icons.settings_suggest_outlined,
//                   onTap: () {
//                     Get.to(() => SettingsView());
//                   },
//                 ),
//                 SizedBox(height: 15.h),
//                 CustomDrawerCardWidget(
//                   cardName: 'Logout',
//                   cardIcon: Icons.logout,
//                   onTap: () {
//                     CustomAlertDialog.showCustomDialog(
//                       title: "Want to Logout account !",
//                       content:
//                           "Please confirm to Logout button to logout your account.",
//                       confirmText: "Confirm",
//                       onConfirm: () {
//                         Get.offAll(() => SignInView());
//
//                         Get.back();
//                       },
//                       cancelText: "Cancel",
//                       onCancel: () {
//                         // Handle cancel action
//                         Get.back();
//                       },
//                       cancelName: 'Cancel',
//                       actionName: 'Logout',
//                     );
//                   },
//                 ),
//               ],
//             ),
//             Positioned(
//               top: 1.0,
//               right: 1.0,
//               child: IconButton(
//                 icon: const Icon(Icons.close, size: 20),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
