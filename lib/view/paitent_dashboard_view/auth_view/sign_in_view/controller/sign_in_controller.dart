// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:restaurent_discount_app/uitilies/api/api_url.dart';
import 'package:restaurent_discount_app/uitilies/api/local_storage.dart';
import 'package:restaurent_discount_app/uitilies/custom_toast.dart';

import 'package:restaurent_discount_app/view/bottom_navigation_view/bottom_navigation_view.dart';

import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/controller/socket_controller.dart';

import 'package:restaurent_discount_app/view/paitent_dashboard_view/auth_view/sign_in_view/profile_complete_view.dart';

import '../../../../bottom_navigation_view/bottom_navigation_bar_for_paitient.dart';

class SignInController extends GetxController {
  var isLoading = false.obs;

  final StorageService _storageService = StorageService();

  final SocketController _socketController =
  Get.put(SocketController());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading(true);

      final map = <String, dynamic>{
        "email": email,
        "password": password,
      };

      print("======================================");
      print("🔐 LOGIN REQUEST");
      print("Request Body: $map");
      print("======================================");

      final response = await http.post(
        Uri.parse(ApiUrl.login),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(map),
      );

      print("Login Status Code: ${response.statusCode}");
      print("Login Response: ${response.body}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        if (responseBody['success'] == true) {
          final data = responseBody['data'];

          String accessToken =
              data['accessToken']?.toString() ?? '';

          String role =
              data['role']?.toString() ?? '';

          String id =
              data['id']?.toString() ?? '';

          dynamic loginCount = data['loginCount'];

          if (accessToken.isEmpty) {
            CustomToast.showToast(
              "Access token not found",
              isError: true,
            );
            return;
          }

          if (id.isEmpty) {
            CustomToast.showToast(
              "User ID not found",
              isError: true,
            );
            return;
          }

          // ===========================================
          // SAVE LOGIN INFORMATION
          // ===========================================

          await _storageService.write(
            'accessToken',
            accessToken,
          );

          await _storageService.write(
            'role',
            role,
          );

          await _storageService.write(
            'id',
            id,
          );

          print("======================================");
          print("✅ LOGIN INFORMATION SAVED");
          print("User ID: $id");
          print("Role: $role");
          print("Token saved: ${accessToken.isNotEmpty}");
          print("======================================");

          // ===========================================
          // IMPORTANT:
          // LOGIN এর পর SOCKET FRESH RECONNECT
          // ===========================================

          await _socketController.reconnectAfterLogin();

          print("======================================");
          print("🔌 SOCKET RECONNECT CALLED");
          print("======================================");

          // ===========================================
          // NAVIGATION
          // ===========================================

          if (role == "NURSE") {
            if (loginCount != null && loginCount > 1) {
              Get.offAll(
                    () => DashboardForNurse(),
              );
            } else {
              Get.offAll(
                    () => ProfileCompleteView(),
              );
            }
          } else if (role == "PATIENT") {
            Get.offAll(
                  () => BottomNavigationBarForPaitient(),
            );
          } else {
            CustomToast.showToast(
              "Invalid role detected",
              isError: true,
            );
            return;
          }

          CustomToast.showToast(
            "Login Successfully Done!",
          );
        } else {
          String errorMessage =
              responseBody['message'] ??
                  'Login failed. Please try again.';

          if (responseBody['errorSources'] != null &&
              responseBody['errorSources'] is List) {
            final List errorSources =
            responseBody['errorSources'];

            for (var error in errorSources) {
              if (error is Map &&
                  error['message'] != null) {
                errorMessage =
                    error['message'].toString();
                break;
              }
            }
          }

          CustomToast.showToast(
            errorMessage,
            isError: true,
          );
        }
      } else {
        CustomToast.showToast(
          "Invalid Credentials",
          isError: true,
        );
      }
    } catch (e, stackTrace) {
      print("======================================");
      print("❌ LOGIN ERROR");
      print(e);
      print(stackTrace);
      print("======================================");

      CustomToast.showToast(
        e.toString(),
        isError: true,
      );
    } finally {
      isLoading(false);
    }
  }
}