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
        backgroundColor: Color.fromRGBO(30, 30, 30, 1),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          InAppWebView(
            key: webViewKey,
            initialUrlRequest: null,
            initialSettings: settings,
            onWebViewCreated: (controller) async {
              webViewController = controller;
              if (widget.cookieData != null) {
                print(widget.cookieData);
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
                await CookieManager.instance().setCookie(
                  webViewController: webViewController, // ini penting
                  url: uri,
                  name: sessionCookie[0],
                  value: sessionCookie[1].replaceAll(";", ''),
                  domain: uri.host,
                  path: '/',
                  isHttpOnly: true,
                  isSecure: false,
                );
              }

              await controller.loadData(
                data: '''
                <html>
                <script>
                  sessionStorage.setItem("contentstring", "${widget.contentstring}");
                  location.href = "${widget.url}";
                        sessionStorage.setItem("_dr", "${widget.querystring}");
                  location.href = "${widget.url}";
                </script>
                </html>
              ''',
                baseUrl: WebUri(widget.url!),
              );

              // await Future.delayed(const Duration(milliseconds: 300));
              // await controller.loadUrl(urlRequest: URLRequest(url: uri));
            },
            onLoadStart: (controller, url) {
              print("Start loading: $url");
            },
            shouldOverrideUrlLoading: (_, __) async {
              return NavigationActionPolicy.ALLOW;
            },
            onLoadStop: (controller, url) async {
              final cookies =
                  await CookieManager.instance().getCookies(url: url!);
              for (var c in cookies) {
                debugPrint("COOKIE: ${c.name} = ${c.value}");
              }

              final html = await controller.evaluateJavascript(
                source: "document.documentElement.innerHTML",
              );
              // debugPrint("Page title: $html");

              final cookiesOne = await CookieManager.instance()
                  .getCookie(url: url, name: "ASP.NET_SessionId");
              print(cookiesOne);
              final documentCookie = await controller.evaluateJavascript(
                source: "document.cookie",
              );
              print("JS cookie from document: $documentCookie");
            },
            onProgressChanged: (_, int progress) {
              setState(() {
                this.progress = progress / 100;
              });
              print("Progress: $progress%");
            },
            onConsoleMessage: (controller, consoleMessage) {
              print(
                  "📢 WebView Console: ${consoleMessage.messageLevel} - ${consoleMessage.message}");
            },
          ),
          if (progress < 1.0)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
