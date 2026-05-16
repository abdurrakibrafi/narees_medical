import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/app_colors.dart';

class AddPatientChartingViaWebview extends GetxController {
  var isLoading = false.obs;

  addPatientCharting({required String appointmentId}) async {
    try {
      isLoading(true);

      final String chartingUrl =
          ApiUrl.getChartingForm(appointmentId: appointmentId);

      // Navigate to WebView

      print(chartingUrl);
      Get.to(() => ChartingWebViewPage(url: chartingUrl));
    } catch (e) {
      debugPrint("Error occurred: $e");
    } finally {
      isLoading(false);
    }
  }
}

// ✅ WebView Page
class ChartingWebViewPage extends StatefulWidget {
  final String url;

  const ChartingWebViewPage({
    super.key,
    required this.url,
  });

  @override
  State<ChartingWebViewPage> createState() => _ChartingWebViewPageState();
}

class _ChartingWebViewPageState extends State<ChartingWebViewPage> {
  late final WebViewController _webViewController;

  bool _isPageLoading = true;

  @override
  void initState() {
    super.initState();

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() => _isPageLoading = true);
          },
          onPageFinished: (_) {
            setState(() => _isPageLoading = false);
          },
          onWebResourceError: (error) {
            debugPrint("WebView error: ${error.description}");
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Patient Charting Form"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _webViewController),
          if (_isPageLoading)
            Center(
              child: CircularProgressIndicator(
                color: AppColors.mainColor,
              ),
            ),
        ],
      ),
    );
  }
}
