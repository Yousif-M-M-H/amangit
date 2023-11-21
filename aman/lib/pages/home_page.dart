import 'package:aman/pages/web_view.dart';
import 'package:amanpack/amanpack.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AmanPage(
                  onPaymentSuccess: (cashierUrl, cancelUrl, callbackUrl, returnUrl) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewContainer(cashierUrl: cashierUrl, cancelUrl: cancelUrl, callbackUrl: callbackUrl, returnUrl: returnUrl,)));                  },
                ),
              ),
            );
          },
          child: const Text('Try aman package'),
        ),
      ),
    );
  }
}

