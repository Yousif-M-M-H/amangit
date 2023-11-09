// hello bard, i'm yousif what's wrong here when i reach youtube no snackbar is displayed in the screen


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
  void initState() {
    super.initState();
    controller = WebViewController()
      ..enableZoom(false)
      ..setNavigationDelegate(
        
        NavigationDelegate(
        onPageStarted: (url) {
          
        },        
        onNavigationRequest: (request) {
          if (request.url.startsWith(widget.returnUrl)) {
            
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse('https://google.com/'),
      );
  }
// http://aman-checkout.mimocodes.com/${widget.cashierUrl}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web view'),
      ),
      body: WebViewWidget(
        controller:   WebViewController()
      ..enableZoom(false)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) {
          if (request.url.startsWith(widget.returnUrl)) {
            print("Hello");
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse('https://google.com/'),
      )
      )
    );
  }
}



