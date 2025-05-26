import 'dart:convert';

import 'package:famlimited/reusables/reuseconf.dart';
import 'package:famlimited/reusables/shimmer.dart';
import 'package:famlimited/ytube.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DispGal extends StatefulWidget {
  final dynamic data;
  
  const DispGal({
    super.key,
    required this.data,
  });

  @override
  State<DispGal> createState() => _DispGalState();
}

class _DispGalState extends State<DispGal> {
  int _currentImageIndex = 0;
  late final List<dynamic> _images;

  @override
  void initState() {
    super.initState();
    _images = jsonDecode(widget.data['images']);
  }

  void _previousImage() {
    setState(() {
      _currentImageIndex = _currentImageIndex > 0 ? _currentImageIndex - 1 : 0;
    });
  }

  void _nextImage() {
    setState(() {
      _currentImageIndex = _currentImageIndex < _images.length - 1 ? _currentImageIndex + 1 : 0;
    });
  }

  void _selectImage(int index) {
    setState(() {
      _currentImageIndex = index;
    });
  }

  Widget _buildNavigationButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon, size: 60, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildThumbnail(String imagePath, int index) {
    return InkWell(
      onTap: () => _selectImage(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        width: 150,
        height: 100,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: imagePath.length > 30 ? imagePath : "${auth.imgurl}/$imagePath",
            fit: BoxFit.cover,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(color: Colors.white),
            ),
            errorWidget: (context, url, error) => RetryableImage(
              imagePath: "${auth.imgurl}/$imagePath",
              baseUrl: "${auth.imgurl}/$imagePath",
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 0.93,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              _buildHeader(),
              _buildMainImage(),
              _buildThumbnails(),
              if (widget.data['videolink'] != null && widget.data['videolink'].isNotEmpty)
                _buildVideoSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.navigate_before, size: 30),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.data['propName'],
                  style: TextStyle(
                    color: Colors.indigo.shade800,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMainImage() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider("${auth.imgurl}/${_images[_currentImageIndex]}"),
          fit: BoxFit.contain,
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavigationButton(Icons.navigate_before_outlined, _previousImage),
            _buildNavigationButton(Icons.navigate_next_outlined, _nextImage),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnails() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _images.asMap().entries.map((entry) {
          return _buildThumbnail(entry.value, entry.key);
        }).toList(),
      ),
    );
  }

  Widget _buildVideoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(thickness: 1, color: Colors.black12),
        const SizedBox(height: 20),
        Text(
          'Video',
          style: GoogleFonts.kanit(
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 24,
          ),
        ),
        Container(
          height: 400,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IframeScreen(url: widget.data['videolink']),
        ),
      ],
    );
  }
}
