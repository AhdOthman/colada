import 'dart:io';

import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MenuPage extends StatefulWidget {
  final String webViewUrl;
  const MenuPage({Key? key, required this.webViewUrl}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Menu",
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: widget.webViewUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
