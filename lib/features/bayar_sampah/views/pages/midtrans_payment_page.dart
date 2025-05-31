import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:satu_desa/features/bayar_sampah/views/pages/bayar_sampah_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MidtransPaymentPage extends StatefulWidget {
  final String snapToken;

  const MidtransPaymentPage({super.key, required this.snapToken});

  @override
  State<MidtransPaymentPage> createState() => _MidtransPaymentPageState();
}

class _MidtransPaymentPageState extends State<MidtransPaymentPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    final snapUrl =
        'https://app.sandbox.midtrans.com/snap/v2/vtweb/${widget.snapToken}';

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint("Loading: $progress%");
          },
          onPageStarted: (String url) {
            debugPrint("Start: $url");
          },
          onPageFinished: (String url) {
            if (url.contains("example.com")) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BayarSampahPage(),
                  ));
              AwesomeDialog(
                  context: context,
                  animType: AnimType.scale,
                  dialogType: DialogType.success,
                  title: "Pembayaran Berhasil",
                  btnOkText: "Selesai");
            }
          },
          onHttpError: (HttpResponseError error) {
            debugPrint("HTTP error: ${error.response}");
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint("Web error: ${error.description}");
          },
          onNavigationRequest: (NavigationRequest request) {
            // Blokir URL yang tidak diinginkan jika perlu
            if (request.url.contains('some-dangerous-site.com')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(snapUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: controller),
    );
  }
}
