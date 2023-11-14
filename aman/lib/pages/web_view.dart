
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  final String cashierUrl;
  final String cancelUrl;
  final String callbackUrl;
  final String returnUrl;

  const WebViewContainer(
      {Key? key,
      required this.cashierUrl,
      required this.cancelUrl,
      required this.callbackUrl,
      required this.returnUrl})
      : super(key: key);

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  late final WebViewController controller;
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web view'),
       leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).primaryColorDark,
        )),
      ),
      body: WebViewWidget(
      controller: WebViewController()
        ..enableZoom(false)
        ..setNavigationDelegate(NavigationDelegate(
          onNavigationRequest: (request) {
            if (request.url ==
                "http://aman-checkout.mimocodes.com/${widget.cashierUrl}/payment-method") {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Hello to flutter install")));
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ))
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(
          Uri.parse('http://aman-checkout.mimocodes.com/${widget.cashierUrl}'),
        ))
    );
  }
}

// http://aman-checkout.mimocodes.com/${widget.cashierUrl}
//aman-checkout.mimocodes.com/14505055ab0cc78c90ba7de6fc34f84f14ea5aa3f090781c34/reference-code-2