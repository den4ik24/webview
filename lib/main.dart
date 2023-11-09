import 'package:flutter/material.dart';
import 'package:webview/my_website.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const WebView(),
        '/webViewContainer': (context) => const WebViewContainer(),
      },
    ),
  );
}

class WebView extends StatefulWidget {
  const WebView({super.key});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/dino.gif"),
            fit: BoxFit.cover,
          ),
        ),
        child: content(),
      ),
    );
  }

  Widget content() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/webViewContainer");
        },
        clipBehavior: Clip.antiAlias,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.yellow,
            shadowColor: Colors.black,
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        child: const Text(
          "Wellcome to Dinosaur Database",
          style: TextStyle(
            fontFamily: "Burlesqu",
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
