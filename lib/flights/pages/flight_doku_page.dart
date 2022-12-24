import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:kai_wisata/flights/arguments/flight_doku_arguments.dart';
import 'package:kai_wisata/flights/providers/flight_doku_state.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/pages/home/home_page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FlightDokuPage extends StatefulWidget {
  static const routeName = '/flight-doku-payment-pages';
  const FlightDokuPage({Key? key}) : super(key: key);

  @override
  State<FlightDokuPage> createState() => _FlightDokuPageState();
}

class _FlightDokuPageState extends State<FlightDokuPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final GlobalKey webViewKey = GlobalKey();

  FlightDokuState state = FlightDokuState();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;

  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as FlightDokuArguments;

    state = Provider.of<FlightDokuState>(context);
    state.initState(context, scaffoldKey, args);

    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: KaiColor.white,
            size: 40.0,
          ),
          onPressed: () async {
            Navigator.pop(context);
            webViewController?.goBack();
            state.onBackButton();
          },
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: Text(
          'Payment',
          style: KaiTextStyle.titleSmallBold.apply(color: KaiColor.white),
        ),
        backgroundColor: KaiColor.blue,
        centerTitle: true,
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ],
      ),
      backgroundColor: KaiColor.neutral11,
      body: InAppWebView(
        key: webViewKey,
        // contextMenu: contextMenu,
        initialUrlRequest:
        URLRequest(url: Uri.parse(args.url!)),
        // initialFile: "assets/index.html",
        initialUserScripts: UnmodifiableListView<UserScript>([]),
        initialOptions: options,
        pullToRefreshController: pullToRefreshController,
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        onLoadStart: (controller, url) {
          setState(() {
            this.url = url.toString();
            urlController.text = this.url;
          });
        },
        androidOnPermissionRequest:
            (controller, origin, resources) async {
          return PermissionRequestResponse(
              resources: resources,
              action: PermissionRequestResponseAction.GRANT);
        },
        shouldOverrideUrlLoading:
            (controller, navigationAction) async {
          var uri = navigationAction.request.url!;

          if (![
            "http",
            "https",
            "file",
            "chrome",
            "data",
            "javascript",
            "about"
          ].contains(uri.scheme)) {
            if (await canLaunchUrl(uri)) {
              // Launch the App
              await launchUrl(
                uri,
              );
              // and cancel the request
              return NavigationActionPolicy.CANCEL;
            }
          }

          return NavigationActionPolicy.ALLOW;
        },
        onLoadStop: (controller, url) async {
          pullToRefreshController.endRefreshing();
          setState(() {
            this.url = url.toString();
            urlController.text = this.url;
          });
        },
        onLoadError: (controller, url, code, message) {
          pullToRefreshController.endRefreshing();
        },
        onProgressChanged: (controller, progress) {
          if (progress == 100) {
            pullToRefreshController.endRefreshing();
          }
          setState(() {
            this.progress = progress / 100;
            urlController.text = this.url;
          });
        },
        onUpdateVisitedHistory: (controller, url, androidIsReload) {
          setState(() {
            this.url = url.toString();
            urlController.text = this.url;
          });
        },
        onConsoleMessage: (controller, consoleMessage) {
          print(consoleMessage);
        },
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Container();
  // }
}