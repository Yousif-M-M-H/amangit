import 'package:aman/pages/aman_page.dart';
import 'package:aman/pages/paymentDone.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
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
  var logger = Logger();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    print('this is the reutrn url------------->' + widget.returnUrl);
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
                onPageFinished: (String url) {
                  final expectedBaseUrl =
                      "http://aman-checkout.mimocodes.com/${widget.cashierUrl}";
                  final expectedPaymentMethodUrl =
                      "$expectedBaseUrl/payment-method";
                  if (url == expectedPaymentMethodUrl) {
                    logger.d("you reached to refrence");
                    if (url.contains("/reference-code-2")) {
                      logger.d("Navigating to payment method done!");
                      Future.delayed(const Duration(seconds: 3), () {
                        _navigateToPaymentDone(context);
                      });
                    }
                  }
                },
                onUrlChange: (change) {
                  if (change.url != null) {
                    if (change.url!.startsWith(widget.returnUrl)) {
                      logger.d('Navigating to refrence code page is happend perfectly in the on change url');
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('navigating to the app in 5 second')));
                      Future.delayed(const Duration(seconds: 3), () {
                        _navigateToPaymentDone(context);
                      });
                    }
                  }
                },
                onNavigationRequest: (NavigationRequest request) {
                  if (request.url != null &&
                      request.url.startsWith(widget.returnUrl)) {
                    logger.d(
                        'Prevented navigation to the return URL in onNavigationRequest');
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('navigating to the app in 5 second')));
                    Future.delayed(const Duration(seconds: 3), () {
                      _navigateToPaymentDone(context);
                    });
                    return NavigationDecision.prevent;
                  }

                  return NavigationDecision.navigate;
                },
              ))
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..loadRequest(
                Uri.parse(
                    'http://aman-checkout.mimocodes.com/${widget.cashierUrl}'),
              )));
  }
}

void _navigateToPaymentDone(BuildContext context) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => const PaymentDone()),
  );
}
