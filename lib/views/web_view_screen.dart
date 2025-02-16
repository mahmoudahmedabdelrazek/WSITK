import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


        //developed by : mohamed abdullah
        //phones and whatsapp : +201155849512 & +201091859345
        //linkedin : https://www.linkedin.com/in/muhammed-bn-abdullah/
        //github : https://github.com/MoAbdullahConQ
        //gmail : muhammed.abdullah.01155849512@gmail.com


class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoading = true;

  late WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            // Handle page start.
            setState(() {
              isLoading = true;
            });
            _showLoadingDialog(context); // إظهار ديالوج التحميل
          },
          onPageFinished: (String url) {
            // Handle page finish.
            setState(() {
              isLoading = false;
            });
            _hideLoadingDialog(context); // إخفاء ديالوج التحميل
          },
        ),
      )
      ..loadRequest(Uri.parse('https://wsitk.com/'));
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // المستخدم لا يمكنه إغلاق الديالوج بالنقر خارجها
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent, // خلفية شفافة
          elevation: 0, // إزالة الظل
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/logo.jpeg', // شعار التطبيق
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'جاري التحميل...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop(); // إغلاق الديالوج
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Center(child: Text('وسيطك')),
        // ),
        body: Stack(
          children: [
            WebViewWidget(
              controller: controller,
            ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(), // دائرة تحميل بسيطة كبديل
              ),
          ],
        ),
      ),
    );
  }
}
