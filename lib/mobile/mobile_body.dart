import 'package:famlimited/gallery.dart';
import 'package:famlimited/mobile/mobilePages/mobile_main_body.dart';
import 'package:famlimited/mobile/mobilePages/mobileabout.dart';
import 'package:famlimited/mobile/mobilePages/mobileproplisting.dart';
import 'package:famlimited/testimonials.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import '../controller.dart';
import '../desktop/desktopPages/desktopmenu.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../reusables/reuseconf.dart';


class MobileBody extends StatefulWidget {
  const MobileBody({super.key});

  @override
  State<MobileBody> createState() => _MobileBodyState();
}

class _MobileBodyState extends State<MobileBody> {
  @override
  Widget build(BuildContext context) {

    html.window.onPopState.listen((event) {
      TapController().getView();
      html.window.history.pushState(TapController().getView(), '', html.window.location.href);
      TapController().changeView();
    });

    TapController tapController = Get.put(TapController());


    List menuList = [
      Menus(
        label: "Home",
        widgets: Mobilemainbody(),
        urlend: "index",
      ),
      Menus(
        label: "Listings",
        widgets:MobilePropListing(),
        urlend: "listing",
      ),
      Menus(
        label: "About",
        widgets: MobileAbout(),
        urlend: 'aboutus',
      ),
      Menus(
        label: "Contact",
        widgets: SizedBox(), urlend: 'contactus',
      ),
      Menus(
        label: "Events",
        widgets: SizedBox(),
        urlend: 'events',
      ),
      Menus(
        label: "Gallery",
        widgets: Gallery(crossCount: 2),
        urlend: 'media',
      ),
      Menus(
        label: "Virtual Tour",
        widgets: SizedBox(),
        urlend: 'virtualtour',
      ),
      Menus(
        label: "Testimonials",
        widgets: Testimonials(),
        urlend: 'testimonials',
      )
    ];

    var message = "Hello, I'lld like to enquire more about your products";
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    void initState() {
      super.initState();
      tapController.mobilechangeView();
    }




    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // final Uri whatsappUri = Uri.parse("https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}");
          final Uri uri = Uri.parse("https://wa.me/+254716544543?text=${Uri.encodeComponent("${message}")}");
          if (await canLaunchUrl(uri)) {
            await launchUrl(
              uri,
              mode: LaunchMode.externalApplication, // Ensures a new tab is opened
            );
          } else {
            throw "Could not launch $uri";
          }
        },

        // final Uri whatsappUri = Uri.parse("https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}");


        child: Image.asset("assets/images/whatsapp.webp"),
      ),

      drawer: Container(
        color: Colors.indigo.shade800,
        height: double.infinity,
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: menuList.map((e) => Padding(
              padding: const EdgeInsets.only(left: 40.0,top: 20),
              child: InkWell(
                onTap: ()async{
                  if(e.urlend == "virtualtour"){
                    final Uri uri = Uri.parse("${auth.vtour}/output/index.html");
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication, // Ensures a new tab is opened
                      );
                    } else {
                      throw "Could not launch $uri";
                    }
                  }else{

                    html.window.history.pushState(null, '', "/${e.urlend}");
                    tapController.mobilechangeView();
                    tapController.update();
                    _scaffoldKey.currentState?.closeDrawer();

                  }
                },
                child: Text("${e.label.toUpperCase()}",style: TextStyle(
                  // fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 2,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),),
              ),
            )).toList()
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade800,
        flexibleSpace: Row(
          children: [
            SizedBox(width: 40,),
            Container(
              width: 100,
              height: 50,
              child: Center(child: Image.asset("assets/images/logo.webp")),
            ),
            SizedBox(width: 10,),


          ],
        ),

      ),
      // drawer: ,
      // backgroundColor: Colors.green,
      body: GetBuilder<TapController>(
          builder: (maintapController) {
          return Column(
            children: [
              tapController.mobilechangeView(),
            ],
          );
        }
      ),
    );
  }
}
