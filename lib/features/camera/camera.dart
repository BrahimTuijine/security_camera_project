import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:security_camera_project/constants.dart';
import 'package:security_camera_project/core/widget/custom_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class Camera extends HookWidget {
  Camera({Key? key}) : super(key: key);

  late WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      // #docregion platform_features
      late final PlatformWebViewControllerCreationParams params;
      if (WebViewPlatform.instance is WebKitWebViewPlatform) {
        params = WebKitWebViewControllerCreationParams(
          allowsInlineMediaPlayback: true,
          mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
        );
      } else {
        params = const PlatformWebViewControllerCreationParams();
      }

      final WebViewController controller =
          WebViewController.fromPlatformCreationParams(params);
      // #enddocregion platform_features

      controller
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              debugPrint('WebView is loading (progress : $progress%)');
            },
            onPageStarted: (String url) {
              debugPrint('Page started loading: $url');
            },
            onPageFinished: (String url) {
              debugPrint('Page finished loading: $url');
            },
            onWebResourceError: (WebResourceError error) {
              debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
            },
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                debugPrint('blocking navigation to ${request.url}');
                return NavigationDecision.prevent;
              }
              debugPrint('allowing navigation to ${request.url}');
              return NavigationDecision.navigate;
            },
            onUrlChange: (UrlChange change) {
              debugPrint('url change to ${change.url}');
            },
          ),
        )
        ..addJavaScriptChannel(
          'Toaster',
          onMessageReceived: (JavaScriptMessage message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message.message)),
            );
          },
        )
        ..loadRequest(
          Uri.parse(
            'http://192.168.1.112:81',
          ),
          // headers: {},
        );

      _controller = controller;
      return null;
    }, const []);
    // final isRunning = useState<bool>(true);
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: const CustomAppBar(title: "Camera"),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:security_camera_project/constants.dart';
// import 'package:security_camera_project/core/widget/custom_app_bar.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

// class Camera extends HookWidget {
//   Camera({Key? key}) : super(key: key);


//   double progress = 0;
//   late InApp

//   @override
//   Widget build(BuildContext context) {
//     // final isRunning = useState<bool>(true);
//     return Scaffold(
//         backgroundColor: kBgColor,
//         appBar: const CustomAppBar(title: "Camera"),
//         body: Stack(
//           children: [],
//         ));
//   }
// }
