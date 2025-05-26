import 'dart:convert';

import 'package:famlimited/dispgal.dart';
import 'package:famlimited/reusables/reuseconf.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'desktop/desktopPages/footer.dart';

class Gallery extends StatefulWidget {
  final String ? mobile;
  final int crossCount;
  const Gallery({super.key,this.mobile, required this.crossCount});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<dynamic> _galleryImages = [];
  final Map<int, double> _scaleMap = {};

  @override
  void initState() {
    super.initState();
    _getImages();
  }

  Future<void> _getImages() async {
    final result = await auth.getvalues("property/proplisting/list");
    if (mounted) {
      setState(() {
        _galleryImages = result;
      });
    }
  }

  void _onEnter(int index) {
    setState(() {
      _scaleMap[index] = 1.01;
    });
  }

  void _onExit(int index) {
    setState(() {
      _scaleMap[index] = 1.0;
    });
  }

  Widget _buildGalleryItem(BuildContext context, int index) {
    final item = _galleryImages[index];
    final images = item["images"] == null ? [] : jsonDecode(item['images']);
    final scale = _scaleMap[index] ?? 1.0;

    return MouseRegion(
      onEnter: (_) => _onEnter(index),
      onExit: (_) => _onExit(index),
      child: Transform.scale(
        scale: scale,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DispGal(data: item),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider("${auth.imgurl}/${images[0]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.black12,
              child: Center(
                child: Text(
                  item['propName'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.93,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: widget.mobile == "true"
                  ? const EdgeInsets.all(10.0)
                  : const EdgeInsets.only(top: 280),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: widget.mobile == "true" ? 1 : widget.crossCount,
                        childAspectRatio: widget.mobile == "true"
                            ? MediaQuery.of(context).size.width / 2 / 150
                            : MediaQuery.of(context).size.width / 2 / 500,
                      ),
                      itemCount: _galleryImages.length,
                      itemBuilder: _buildGalleryItem,
                    ),
                  ),
                ),
              ),
            ),
            widget.mobile == "desktop" ? DektopFooter() : DektopFooter(mobile: "true",),
          ],
        ),
      ),
    );
  }
}
