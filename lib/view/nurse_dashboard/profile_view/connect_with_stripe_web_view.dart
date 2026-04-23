import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StripeWebViewScreen extends StatefulWidget {
  final String url;

  const StripeWebViewScreen({super.key, required this.url});

  @override
  State<StripeWebViewScreen> createState() => _StripeWebViewScreenState();
}

class _StripeWebViewScreenState extends State<StripeWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) => setState(() => _isLoading = false),
          onWebResourceError: (error) {
            debugPrint('WebView error: ${error.description}');
          },
          // ✅ Stripe সফলভাবে শেষ হলে redirect URL ধরবে
          onNavigationRequest: (request) {
            debugPrint('Navigating to: ${request.url}');

            // আপনার success/return URL এখানে match করুন
            if (request.url.contains('your-app.com/stripe/success')) {
              Get.back(); // WebView বন্ধ করবে
              // চাইলে success screen এ যেতে পারেন:
              // Get.offAllNamed('/stripe-success');
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Connect with Stripe',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Get.back(),
        ),
        actions: [
          // Reload button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _controller.reload(),
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),

          // Loading indicator
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF0071BC),
              ),
            ),
        ],
      ),
    );
  }
}