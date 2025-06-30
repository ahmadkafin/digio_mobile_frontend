import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:myapp/core/utils/styleText.utils.dart';

class ChildWithPagesPresentation extends StatefulWidget {
  const ChildWithPagesPresentation({
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
  State<ChildWithPagesPresentation> createState() =>
      _ChildWithPagesPresentationState();
}

class _ChildWithPagesPresentationState
    extends State<ChildWithPagesPresentation> {
  final GlobalKey webViewKeys = GlobalKey();
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
          InAppWebView(
            key: webViewKeys,
            initialUrlRequest: null,
            initialSettings: settings,
            onWebViewCreated: (controller) async {
              webViewController = controller;
              if (widget.cookieData != null) {
                var sessionCookie = widget.cookieData!.trim().split("=");
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
              if (widget.contenttype != null) {
                await CookieManager.instance().setCookie(
                  webViewController: controller,
                  url: uri,
                  name: "_dtype",
                  value: widget.contenttype ?? "",
                  domain: uri.host,
                  isHttpOnly: true,
                  isSecure: false,
                  path: '/',
                );
              }

              if (widget.contentstring != null) {
                await CookieManager.instance().setCookie(
                  webViewController: controller,
                  url: uri,
                  name: "_dcontent",
                  value: widget.contentstring ?? "",
                  domain: uri.host,
                  isHttpOnly: true,
                  isSecure: false,
                  path: '/',
                );
              }

              await Future.delayed(const Duration(milliseconds: 300));
              await controller.loadUrl(urlRequest: URLRequest(url: uri));
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
                "📢 WebView Console: ${consoleMessage.messageLevel} - ${consoleMessage.message}",
              );
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
