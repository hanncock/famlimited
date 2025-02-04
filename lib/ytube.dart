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

  IframeScreen({required this.url}) {
    // Process the URL based on its type
    String processedUrl = _processUrl(url);

    ui_web.platformViewRegistry.registerViewFactory(
      'iframe-$url',
          (int viewId) => IFrameElement()
        ..src = processedUrl
        ..style.border = 'none'
        ..width = '100%'
        ..height = '100%'
        ..allow = "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
        ..allowFullscreen = true
        ..style.backgroundColor = 'transparent',
    );
  }

  String _processUrl(String inputUrl) {
    // Check if it's a YouTube URL
    if (inputUrl.contains('youtube.com') || inputUrl.contains('youtu.be')) {
      String videoId = _getYoutubeVideoId(inputUrl);
      return 'https://www.youtube.com/embed/$videoId';
    }
    // Check if it's a Google Drive URL
    else if (inputUrl.contains('drive.google.com')) {
      String fileId = _getDriveFileId(inputUrl);
      return 'https://drive.google.com/file/d/$fileId/preview';
    }
    // Return original URL if neither
    return inputUrl;
  }

  String _getYoutubeVideoId(String youtubeUrl) {
    RegExp regExp = RegExp(
      r'^.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/|shorts\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*',
    );
    final match = regExp.firstMatch(youtubeUrl);
    return match?.group(1) ?? youtubeUrl;
  }

  String _getDriveFileId(String driveUrl) {
    // Handle both /file/d/ and ?id= formats
    RegExp fileRegExp = RegExp(r'\/file\/d\/([^\/]+)');
    RegExp idRegExp = RegExp(r'id=([^&]+)');

    var fileMatch = fileRegExp.firstMatch(driveUrl);
    if (fileMatch != null) {
      return fileMatch.group(1) ?? driveUrl;
    }

    var idMatch = idRegExp.firstMatch(driveUrl);
    if (idMatch != null) {
      return idMatch.group(1) ?? driveUrl;
    }

    return driveUrl;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: HtmlElementView(viewType: 'iframe-$url'),
    );
  }
}