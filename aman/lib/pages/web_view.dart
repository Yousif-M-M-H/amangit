import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class WebViewContainer extends StatefulWidget {
  final String cashierUrl;
  const WebViewContainer({Key? key, required this.cashierUrl}) : super(key: key);

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  late WebViewController _webViewController;

Future<bool> _onBackPressed() async {
  final result = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Do you really want to exit the payment page"),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child:const Text("No")),
        TextButton(onPressed: () => Navigator.pop(context, true), child:const Text("Yes")),
      ],
    ),
  );

  return result;
}


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Web view'),
        ),
        body: WebViewWidget(
          controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(
            Uri.parse('http://aman-checkout.mimocodes.com/${widget.cashierUrl}'),
          ),
          
        ),
      ),
    );
  }


}
