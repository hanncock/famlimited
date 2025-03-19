import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMedia extends StatefulWidget {
  const SocialMedia({super.key});

  @override
  State<SocialMedia> createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {

  List media = [
    {
      // "image":"facebook.png",
      "image":"fb.png",
      "url_launch":"https://www.facebook.com/share/1F11S2ukH7/?mibextid=wwXIfr"
    },
    {
      "image":"insta.png",
      "url_launch":"https://www.instagram.com/fam_limited_global?igsh=MTFsdnMweDViZ2E4bQ%3D%3D&utm_source=qr"
    },
    {
      "image":"tiktok.png",
      "url_launch":"https://www.tiktok.com/@fam.limited.global?_t=ZM-8tDpp36UjKg&_r=1"
    },
    {
      "image":"yt.png",
    }
  ];


  Future<void> openInNewTab(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // Ensures a new tab is opened
      );
    } else {
      throw "Could not launch $url";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: IntrinsicHeight(
        child: Row(
          children: List.generate(media.length, (index) => InkWell(
            onTap: (){
              openInNewTab(media[index]['url_launch']);
            },
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                    image: AssetImage("assets/images/${media[index]['image']}"),
                    // Specify the image asset
                    fit: BoxFit.cover, // Adjust the image fit
                  ),
                    ),
                  ),
                  VerticalDivider(thickness: 1,color: Colors.black12,)
                ],
              )),
          ),
        ),
      ),
    );
  }
}
