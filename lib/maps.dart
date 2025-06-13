/*
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // Import kIsWeb
import 'dart:ui' as ui;
import 'dart:html';


class GoogleMapEmbed extends StatefulWidget {
  final double height;
  final double width;

  const GoogleMapEmbed({
    super.key,
    this.height = 400,
    this.width = double.infinity,
  });

  @override
  State<GoogleMapEmbed> createState() => _GoogleMapEmbedState();
}

class _GoogleMapEmbedState extends State<GoogleMapEmbed> {
  static const String _mapUrl = 'https://www.google.com/maps/embed'
      '?origin=mfe'
      '&pb=!1m3!2m1!1sruiru+villas+estate!6i14!3m1!1sen!5m1!1sen';

  static const String _viewType = 'iframeElement';
  late final Widget _iframeWidget;

  @override
  void initState() {
    super.initState();
    _initializeIframe();
  }

  void _initializeIframe() {
    if (kIsWeb) { // Check if running on web
      final iframeElement = IFrameElement()
        ..style.height = '100%'
        ..style.width = '100%'
        ..src = _mapUrl
        ..style.border = 'none'
        ..allow = 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture'
        ..allowFullscreen = true;

      // Register view factory
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(
        _viewType,
            (int viewId) => iframeElement,
      );

      _iframeWidget = HtmlElementView(
        viewType: _viewType,
      );
    } else {
      // Provide a fallback for non-web platforms, or handle as an error
      // For example, display a message or a placeholder.
      _iframeWidget = Center(
        child: Text('Google Maps embedding is only available on the web.'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: _iframeWidget,
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// Web-only imports with conditional compilation
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

class GoogleMapEmbed extends StatefulWidget {
  final double height;
  final double width;

  const GoogleMapEmbed({
    super.key,
    this.height = 400,
    this.width = double.infinity,
  });

  @override
  State<GoogleMapEmbed> createState() => _GoogleMapEmbedState();
}

class _GoogleMapEmbedState extends State<GoogleMapEmbed> {
  static const String _mapUrl = 'https://www.google.com/maps/embed'
      '?origin=mfe'
      '&pb=!1m3!2m1!1sruiru+villas+estate!6i14!3m1!1sen!5m1!1sen';

  late final Widget _iframeWidget;

  @override
  void initState() {
    super.initState();
    _initializeIframe();
  }

  void _initializeIframe() {
    if (kIsWeb) {
      final viewType = 'iframe-${DateTime.now().millisecondsSinceEpoch}';

      final iframeElement = html.IFrameElement()
        ..style.height = '100%'
        ..style.width = '100%'
        ..src = _mapUrl
        ..style.border = 'none'
        ..setAttribute('allow', 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture')
        ..setAttribute('allowfullscreen', 'true')
        ..setAttribute('loading', 'lazy');

      // Use dart:ui_web for platformViewRegistry
      ui_web.platformViewRegistry.registerViewFactory(
        viewType,
            (int viewId) => iframeElement,
      );

      _iframeWidget = HtmlElementView(
        viewType: viewType,
      );
    } else {
      _iframeWidget = _buildFallbackWidget();
    }
  }

  Widget _buildFallbackWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.map,
              size: 48,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'Google Maps',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Map embedding is only available on web',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: _iframeWidget,
      ),
    );
  }
}