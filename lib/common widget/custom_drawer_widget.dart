// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:restaurent_discount_app/common%20widget/custom_alert_dialog.dart';
// import 'package:restaurent_discount_app/common%20widget/custom_drawer_card_widget.dart';
// import 'package:restaurent_discount_app/uitilies/app_colors.dart';
// import 'package:restaurent_discount_app/uitilies/app_images.dart';
// import 'package:restaurent_discount_app/view/auth%20view/sign%20in%20view/sign_in_view.dart';
// import 'package:restaurent_discount_app/view/chat%20view/chat_view_vendor.dart';
// import 'package:restaurent_discount_app/view/favourite%20view/meals_type_view.dart';
// import 'package:restaurent_discount_app/view/feedback%20view/feedback_view.dart';
// import 'package:restaurent_discount_app/view/group%20dining%20view/group_dining_book_view.dart';
// import 'package:restaurent_discount_app/view/group%20dining%20view/special_occasions_view.dart';
// import 'package:restaurent_discount_app/view/near%20by%20view/near_by_view.dart';
// import 'package:restaurent_discount_app/view/profile%20view/profile_view.dart';
// import 'package:restaurent_discount_app/view/reedem%20view/reedem_view.dart';
// import 'package:restaurent_discount_app/view/settings%20view/settings_view.dart';
// import 'package:restaurent_discount_app/view/subscriptions%20view/subscriptions_view.dart';
//
// class CustomDrawer extends StatelessWidget {
//   const CustomDrawer({Key? key}) : super(key: key);
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
//
//                 // CustomDrawerCardWidget(
//                 //   cardName: 'Feedback',
//                 //   cardIcon: Icons.info_outline,
//                 //   onTap: () {
//                 //     Get.to(() => FeedbackView());
//                 //   },
//                 // ),
//                 SizedBox(height: 15.h),
//                 CustomDrawerCardWidget(
//                   cardName: 'Profile',
//                   cardIcon: Icons.person_2_outlined,
//                   onTap: () {
//                     Get.to(() => ProfileView());
//                   },
//                 ),
//                 SizedBox(height: 15.h),
//                 CustomDrawerCardWidget(
//                   cardName: 'Subscriptions',
//                   cardIcon: Icons.subscriptions_outlined,
//                   onTap: () {
//                     Get.to(() => SubscriptionsView());
//                   },
//                 ),
//                 SizedBox(height: 15.h),
//                 CustomDrawerCardWidget(
//                   cardName: 'Redeem History',
//                   cardIcon: Icons.history,
//                   onTap: () {
//                     Get.to(() => ReedemView());
//                   },
//                 ),
//                 SizedBox(height: 15.h),
//                 CustomDrawerCardWidget(
//                   cardName: 'Group Dining ',
//                   cardIcon: Icons.dinner_dining,
//                   onTap: () {
//                     Get.to(() => GroupDiningBookView());
//                   },
//                 ),
//
//                 SizedBox(height: 15.h),
//                 CustomDrawerCardWidget(
//                   cardName: 'Chat',
//                   cardIcon: Icons.chat_bubble_outline_outlined,
//                   onTap: () {
//                     Get.to(() => ChatViewVendor());
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
//                 SizedBox(height: 15.h),
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
