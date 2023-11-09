import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';



class WebViewContainer extends StatefulWidget {
  const WebViewContainer({super.key});

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
// double _progress = 0;
//   final controller = WebViewController()
//   ..setJavaScriptMode(JavaScriptMode.unrestricted)
//   ..loadRequest(Uri.parse("https://dinosaurpictures.org/"));

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("The Dinosaur Database"),
//       ),
//       body: WebViewWidget(controller: controller),
//     );
//   }

  bool _loading = true;
  late final WebViewController _controller;

  @override
  void initState() {
    _controller = WebViewController.fromPlatformCreationParams(
        const PlatformWebViewControllerCreationParams())
      ..setNavigationDelegate(NavigationDelegate(
          onPageFinished: (_) => setState(() {
                _loading = false;
              })))
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse("https://dinosaurpictures.org/"));

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (await _controller.canGoBack()) {
            _controller.goBack();
            return false;
          } else {
            return true;
          }
        },
        child: Stack(children: [
          WebViewWidget(controller: _controller),
          if (_loading)
            const Center(
              child: CircularProgressIndicator(),
            )
        ]),
      ),
    );
  }
}
