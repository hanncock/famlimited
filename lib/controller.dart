import 'package:famlimited/desktop/admin/adduser.dart';
import 'package:famlimited/events.dart';
import 'package:famlimited/gallery.dart';
import 'package:famlimited/mobile/mobilePages/mobilecontact.dart';
import 'package:famlimited/mobile/mobilePages/mobilepropdetail.dart';
import 'package:famlimited/reusables/reuseconf.dart';
import 'package:famlimited/testimonials.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:html' as html;
import 'desktop/admin/createProp.dart';
import 'desktop/admin/toggleoptions.dart';
import 'desktop/desktopPages/desktopPageContents.dart';
import 'package:famlimited/desktop/desktopPages/aboutus.dart';
import 'package:famlimited/desktop/desktopPages/contactus.dart';
import 'desktop/desktopPages/propListing.dart';
import 'desktop/desktopPages/propdetail.dart';
import 'mobile/mobilePages/mobile_main_body.dart';
import 'mobile/mobilePages/mobileabout.dart';
import 'mobile/mobilePages/mobileproplisting.dart';
import 'package:url_launcher/url_launcher.dart';


class TapController extends GetxController{

  var currentUrl;

  mobilechangeView(){
    String currentUrl = html.window.location.href;
    List<String> parts = currentUrl.split('/');
    switch (parts[3]) {
      case 'index':
        return Mobilemainbody();
      case 'listing':
        return MobilePropListing();
      case 'property':
        return MobilePropDetail();
      case 'testimonials':
        return Testimonials();
      case 'aboutus':
        return MobileAbout();
      case 'contactus':
        return MobileContactUs();
      case 'media':
        return Gallery(mobile:"true", crossCount: 1, );
      case 'events':
        return Events(mobile:"true", crossCount: 1, );
      default:
        return Mobilemainbody();
    }

  }

  launchVirtual()async{
    final Uri uri = Uri.parse("${auth.url}/output/index.html");
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // Ensures a new tab is opened
      );
    } else {
      throw "Could not launch $uri";
    }
  }


  changeView(){
    String currentUrl = html.window.location.href;
    List<String> parts = currentUrl.split('/');
    // print(parts.length);

    if (parts.length > 3) {
      // update();
      switch (parts[3]) {
        case 'index':
          return DesktopContents();
        case 'listing':
          return PropListing();
        case 'property':
          return PropDetail();
        case 'adminlogin':
          // return CreateProp();
          return TogleAdmin();
        case 'addstaff':
          return AddUser();
        case 'aboutus':
          return AboutUs();
        case 'testimonials':
          return Testimonials(mbl: "desktop",);
        case 'contactus':
          return ContactUs();
        case 'media':
          return Gallery(crossCount: 3,);
        case 'events':
          return Events(crossCount: 1, );
        default:
          return DesktopContents();
      }
    } else {
      return DesktopContents(); // Default view if URL is malformed
    }
  }

  getView(){
    String currentUrl = html.window.location.href;
    List<String> parts = currentUrl.split('/');
    return parts[3];
  }


  showloader(){

    bool loader = false;
    if(loader == true){
      loader == false;
    }else{
      loader == true;
    }
    update();
    return loader;


  }

  updatee(){
    update();
  }

}