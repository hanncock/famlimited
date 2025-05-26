import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';


Widget shimmerPlaceholder(double width, double height) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}


class RetryableImage extends StatefulWidget {
  final String imagePath;
  final String baseUrl;

  const RetryableImage({
    Key? key,
    required this.imagePath,
    required this.baseUrl,
  }) : super(key: key);

  @override
  State<RetryableImage> createState() => _RetryableImageState();
}

class _RetryableImageState extends State<RetryableImage> {
  late String imageUrl;
  int retryCount = 0;

  @override
  void initState() {
    super.initState();
    imageUrl = widget.imagePath.length > 30
        ? widget.imagePath
        : "${widget.baseUrl}/${widget.imagePath}";
  }

  void _retryLoading() async {
    await CachedNetworkImage.evictFromCache(imageUrl);
    setState(() {
      retryCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "$imageUrl?retry=$retryCount", // Cache-busting query
      fit: BoxFit.cover,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(color: Colors.white),
      ),
      errorWidget: (context, url, error) => GestureDetector(
        onTap: _retryLoading,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.refresh, color: Colors.grey),
            SizedBox(height: 4),
            Text("Tap to retry", style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
