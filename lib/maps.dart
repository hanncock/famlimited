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
import 'package:flutter/widgets.dart';

class GoogleMapEmbed extends StatefulWidget {
  final double height;
  final double width;

  const GoogleMapEmbed({
    Key? key,
    this.height = 400,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  State<GoogleMapEmbed> createState() => _GoogleMapEmbedState();
}

class _GoogleMapEmbedState extends State<GoogleMapEmbed> {
  final String mapUrl = 'https://www.google.com/maps/embed'
      '?origin=mfe'
      '&pb=!1m3!2m1!1sruiru+villas+estate!6i14!3m1!1sen!5m1!1sen';

  final IFrameElement _iframeElement = IFrameElement();
  Widget? _iframeWidget;

  @override
  void initState() {
    super.initState();
    _iframeElement.style.height = '100%';
    _iframeElement.style.width = '100%';
    _iframeElement.src = mapUrl;
    _iframeElement.style.border = 'none';

    // Register view factory
    final String viewType = 'iframeElement';
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      viewType,
          (int viewId) => _iframeElement,
    );

    _iframeWidget = HtmlElementView(
      viewType: viewType,
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