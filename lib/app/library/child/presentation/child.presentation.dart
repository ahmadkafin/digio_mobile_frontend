import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:myapp/app/library/child/repositories/child.repositories.dart';
import 'package:myapp/core/utils/styleText.utils.dart';

class ChildPresentation extends StatefulWidget {
  const ChildPresentation({
    super.key,
    required this.cookieData,
    required this.title,
    required this.url,
    required this.contenttype,
    required this.querystring,
    required this.contentstring,
  });
  final String? cookieData, title, contenttype, url, querystring, contentstring;

  @override
  State<ChildPresentation> createState() => _ChildPresentationState();
}

class _ChildPresentationState extends State<ChildPresentation> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
    isInspectable: kDebugMode,
    allowContentAccess: true,
    thirdPartyCookiesEnabled: true,
    sharedCookiesEnabled: true,
    forceDark: ForceDark.AUTO,
    geolocationEnabled: true,
    useWideViewPort: true,
    clearCache: true,
    useShouldOverrideUrlLoading: true,
    allowsInlineMediaPlayback: true,
    javaScriptEnabled: true,
    mediaPlaybackRequiresUserGesture: false,
    cacheEnabled: true,
    userAgent:
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0 Safari/537.36",
  );

  double progress = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    final uri = WebUri(widget.url!);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title ?? "Loading...",
          style: TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () async {
            // Bersihkan cookie dan cache sebelum keluar
            await CookieManager.instance().deleteAllCookies();
            await InAppWebViewController.clearAllCache();
            // Kembali ke halaman sebelumnya
            if (mounted) Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color.fromRGBO(30, 30, 30, 1),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // WebView hanya muncul kalau progress >= 1.0
          Offstage(
            offstage: progress < 1.0,
            child: InAppWebView(
              key: webViewKey,
              initialUrlRequest: null,
              initialSettings: settings,
              onWebViewCreated: (controller) async {
                webViewController = controller;
                // Inject cookie
                if (widget.cookieData != null) {
                  var sessionCookie = widget.cookieData!.trim().split('=');
                  await CookieManager.instance().setCookie(
                    webViewController: controller,
                    url: uri,
                    name: sessionCookie[0],
                    value: sessionCookie[1].replaceAll(";", ''),
                    domain: uri.host,
                    isHttpOnly: true,
                    isSecure: false,
                    path: '/',
                  );
                }

                // Inject sessionStorage dan redirect
                await controller.loadData(
                  data: '''
                    <html>
                    <script>
                      sessionStorage.setItem("contentstring", "${widget.contentstring}");
                      sessionStorage.setItem("_dr", "${widget.querystring}");
                      location.href = "${widget.url}";
                    </script>
                    </html>
                  ''',
                  baseUrl: WebUri(widget.url!),
                );
              },
              onLoadStart: (controller, url) {
                print("Start loading: $url");
              },
              shouldOverrideUrlLoading: (_, __) async {
                return NavigationActionPolicy.ALLOW;
              },
              onLoadStop: (controller, url) async {
                // Handle cookies or other post-load actions
              },
              onProgressChanged: (_, int prog) {
                setState(() {
                  progress = prog / 100;
                });
              },
              onConsoleMessage: (controller, consoleMessage) {
                print(
                    "📢 WebView Console: ${consoleMessage.messageLevel} - ${consoleMessage.message}");
              },
            ),
          ),

          // Progress bar overlay
          if (progress < 1.0)
            Container(
              color: Color.fromRGBO(30, 30, 30, 1),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: deviceSize.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey.shade800,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                    ),
                    Text(
                      (progress * 100).toString(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
