import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({super.key});

  static const List<Map<String, String>> _socialMediaLinks = [
    {
      "image": "fb.png",
      "url_launch": "https://www.facebook.com/share/1F11S2ukH7/?mibextid=wwXIfr"
    },
    {
      "image": "insta.png",
      "url_launch": "https://www.instagram.com/fam_limited_global?igsh=MTFsdnMweDViZ2E4bQ%3D%3D&utm_source=qr"
    },
    {
      "image": "tiktok.png",
      "url_launch": "https://www.tiktok.com/@fam.limited.global?_t=ZM-8tDpp36UjKg&_r=1"
    },
    {
      "image": "yt.png",
    }
  ];

  Future<void> _openInNewTab(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IntrinsicHeight(
        child: Row(
          children: _buildSocialMediaIcons(),
        ),
      ),
    );
  }

  List<Widget> _buildSocialMediaIcons() {
    return List.generate(
      _socialMediaLinks.length,
      (index) => _buildSocialMediaIcon(index),
    );
  }

  Widget _buildSocialMediaIcon(int index) {
    final media = _socialMediaLinks[index];
    final hasUrl = media['url_launch'] != null;

    return InkWell(
      onTap: hasUrl ? () => _openInNewTab(media['url_launch']!) : null,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage("assets/images/${media['image']}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (index < _socialMediaLinks.length - 1)
            const VerticalDivider(thickness: 1, color: Colors.black12),
        ],
      ),
    );
  }
}
