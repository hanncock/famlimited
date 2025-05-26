/*
import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart';
import 'dart:html';
import 'dart:ui' as ui;



class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String htmlId = "7";

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      final mapOptions = MapOptions()
        ..zoom = 12
        ..center = LatLng(37.7749, -122.4194);

      final elem = DivElement()
        ..id = htmlId
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.border = 'none';

      final map = GMap(elem, mapOptions);
      return elem;
    });

    return Scaffold(
      appBar: AppBar(title: Text('Google Maps')),
      body: HtmlElementView(viewType: htmlId),
    );
  }
}*/

import 'package:flutter/material.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: _iframeWidget,
    );
  }
}