// import 'dart:html';
// import 'dart:ui_web' as ui_web;
// import 'package:flutter/material.dart';
//
// class IframeScreen extends StatelessWidget {
//   final String url;
//
//   IframeScreen({required this.url}) {
//     ui_web.platformViewRegistry.registerViewFactory(
//       'iframe-$url',
//           (int viewId) => IFrameElement()
//         ..src = url
//         ..style.border = 'none'
//         ..width = '100%'
//         ..height = '100%'
//         ..allow = "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
//         ..allowFullscreen = true
//         ..style.backgroundColor = 'transparent',
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 500,
//       child: HtmlElementView(viewType: 'iframe-$url'),
//     );
//   }
// }

import 'dart:html';
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';

class IframeScreen extends StatelessWidget {
  final String url;
  static const double _defaultHeight = 500.0;

  IframeScreen({
    super.key,
    required this.url,
  })
  {
    _initializeIframe();
  }

  void _initializeIframe() {
    final processedUrl = _processUrl(url);
    final viewType = 'iframe-$url';

    ui_web.platformViewRegistry.registerViewFactory(
      viewType,
      (int viewId) => IFrameElement()
        ..src = processedUrl
        ..style.border = 'none'
        ..width = '100%'
        ..height = '100%'
        ..allow = 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture'
        ..allowFullscreen = true
        ..style.backgroundColor = 'transparent',
    );
  }

  String _processUrl(String inputUrl) {
    if (inputUrl.contains('youtube.com') || inputUrl.contains('youtu.be')) {
      return 'https://www.youtube.com/embed/${_getYoutubeVideoId(inputUrl)}';
    }
    if (inputUrl.contains('drive.google.com')) {
      return 'https://drive.google.com/file/d/${_getDriveFileId(inputUrl)}/preview';
    }
    return inputUrl;
  }

  String _getYoutubeVideoId(String youtubeUrl) {
    final regExp = RegExp(
      r'^.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/|shorts\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*',
    );
    return regExp.firstMatch(youtubeUrl)?.group(1) ?? youtubeUrl;
  }

  String _getDriveFileId(String driveUrl) {
    final fileRegExp = RegExp(r'\/file\/d\/([^\/]+)');
    final idRegExp = RegExp(r'id=([^&]+)');

    return fileRegExp.firstMatch(driveUrl)?.group(1) ??
           idRegExp.firstMatch(driveUrl)?.group(1) ??
           driveUrl;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _defaultHeight,
      child: HtmlElementView(viewType: 'iframe-$url'),
    );
  }
}