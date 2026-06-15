// ignore_for_file: avoid_print, unnecessary_string_interpolations

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:restaurent_discount_app/uitilies/api/api_url.dart';
import 'package:restaurent_discount_app/uitilies/api/local_storage.dart';
import 'package:restaurent_discount_app/uitilies/custom_toast.dart';

class UploadImageController extends GetxController {
  var isLoading = false.obs;
  var uploadedUrls = <String>[].obs;

  final StorageService _storageService = Get.put(StorageService());

  Future<List<String>> uploadImages({required List<File> files}) async {
    isLoading(true);
    uploadedUrls.clear();

    try {
      final token = _storageService.read<String>('accessToken') ?? '';

      final formData = FormData();

      for (File file in files) {
        formData.files.add(
          MapEntry(
            'files',
            await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            ),
          ),
        );
      }

      final dio = Dio();
      final response = await dio.post(
        '${ApiUrl.uploadImages}',
        data: formData,
        options: Options(
          headers: {
            'token': token,
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 201) {
        final data = response.data;

        if (data['success'] == true) {
          final urls = List<String>.from(data['data']);
          uploadedUrls.assignAll(urls);

          print("✅ Uploaded URLs: $urls");
          return urls;
        } else {
          CustomToast.showToast("Upload failed", isError: true);
          return [];
        }
      } else {
        CustomToast.showToast("Upload failed: ${response.statusCode}",
            isError: true);
        return [];
      }
    } catch (e) {
      print("❌ Upload Error: $e");
      CustomToast.showToast("Something went wrong", isError: true);
      return [];
    } finally {
      isLoading(false);
    }
  }
}
