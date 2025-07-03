import 'package:famlimited/desktop/admin/createProp.dart';
import 'package:famlimited/desktop/desktopPages/propListing.dart';
import 'package:famlimited/gallery.dart';
import 'package:famlimited/reusables/socialmedia.dart';
import 'package:famlimited/testimonials.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../controller.dart';
import '../reusables/reuseconf.dart';
import 'desktopPages/desktopmenu.dart';
import 'package:get/get.dart';
import 'dart:html' as html;
import 'dart:html';

import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';



class DesktopBody extends StatefulWidget {
  const DesktopBody({super.key});

  @override
  State<DesktopBody> createState() => _DesktopBodyState();
}

class _DesktopBodyState extends State<DesktopBody> {

  ScrollController _scrollController = ScrollController();
  List images = [
    'bg1.webp',
    'bg2.webp',
    'bg3.webp',
    'bg4.webp',
  ];


  List menuList = [
    Menus(
      label: "Home",
      widgets: SizedBox(),
      urlend: "index",
    ),
    Menus(
      label: "Listings",
      widgets: PropListing(),
      urlend: "listing",
    ),
    Menus(
      label: "About",
      widgets: SizedBox(),
      urlend: 'aboutus',
    ),
    Menus(
      label: "Contact",
      widgets: SizedBox(),
      urlend: 'contactus',
    ),
    Menus(
      label: "Gallery",
      widgets: Gallery(crossCount: 3),
      urlend: 'media',
    ),
    Menus(
      label: "Testimonials",
      widgets: Testimonials(),
      urlend: 'testimonials',
    ),
    Menus(
      label: "Events",
      widgets: Testimonials(),
      urlend: 'events',
    ),
    Menus(
      label: "Virtual Tour",
      widgets: SizedBox(),
      urlend: 'virtualtour',
    ),
  ];

  var message = "Hello, I'lld like to enquire more about your products";

  var imageInView;
  int _currentImageIndex = 0;
  Color _containerColor = Colors.black12;
  Color _containerTextColor = Colors.white;
  double newheight = 260.00;
  bool hide = false;
  bool _hover1 = false;





  scrollControlCol(){
    _scrollController.addListener(() {
      double scrollOffset = _scrollController.position.pixels;

      setState(() {
        if (scrollOffset < 100) {
          newheight = 260.00;
          hide = false;
          _containerColor = Colors.black12; //
          _containerTextColor = Colors.white;
          // Default color
        } else if (scrollOffset < 200) {
          _containerColor = Color(0xFF140354);
          newheight = 60.00;
          hide = true;
          // _containerTextColor = Colors.black;// Change to green
        } else {
          newheight = 60.00;
          hide = true;
          _containerColor = Color(0xFF140354); // Change to red
        }
      });
    });
  }

  TapController tapController = Get.put(TapController());



  @override
  void initState() {
    super.initState();
    scrollControlCol();
    tapController.changeView();

  }

  @override
  void dispose() {
    // Always dispose the controller when done
    _scrollController.dispose();
    super.dispose();
    tapController.showloader();
  }


  @override
  Widget build(BuildContext context) {

    html.window.onPopState.listen((event) {
      TapController().getView();
      html.window.history.pushState(TapController().getView(), '', html.window.location.href);
      TapController().changeView();
    });

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
            launchwhtsapp(message);
          },

        child: Image.asset("assets/images/whatsapp.webp"),
      ),
      extendBody: true,
      body: GetBuilder<TapController>(
        builder: (maintapController) {
          return maintapController.showloader() ? Text('loading'):
              Stack(
                children: [

                 SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        controller: _scrollController,
                        child: tapController.changeView()
                      ),

                  Container(
                    height: newheight,
                    color: _containerColor,
                    margin: EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [

                        hide ?SizedBox() :Container(
                            width: MediaQuery.of(context).size.width,
                          decoration:BoxDecoration(
                            color: Colors.white
                          ),
                            height: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/logo.webp"),
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.watch_later,color: Color(0xFF140354),),
                                          SizedBox(width: 20,),
                                          Text('09:00AM - 05:00PM',style: GoogleFonts.poppins(
                                              // fontWeight: FontWeight.w700, // Bold weight
                                              // fontStyle: FontStyle.italic, // Italic style
                                              // fontSize: 24,
                                              color: Colors.black
                                          ))
                                        ],
                                      ),
                                      VerticalDivider(thickness: 1,color: Colors.black12,),
                                      Row(
                                        children: [
                                          Icon(Icons.call,color: Color(0xFF140354),),
                                          SizedBox(width: 20,),
                                          Text('+254 716 544 543',style: GoogleFonts.poppins(
                                              color: Colors.black
                                          ))
                                        ],
                                      ),
                                      SizedBox(width: 30,),
                                      Column(
                                        children: [
                                          MouseRegion(
                                            onEnter: (_){
                                              setState(() {
                                                _hover1 = true;
                                              });
                                            },
                                            onExit: (_){
                                              setState(() {
                                                _hover1 = false;
                                              });
                                            },

                                            child: InkWell(
                                              onTap: (){
                                                launchwhtsapp("Hello, I would like to visit some of your property sites");
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                    color: _hover1 ? Color(0xFF140354):Colors.blueAccent.withOpacity(0.1),
                                                    // border: Border.all(width: 1)
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 40),
                                                  child: Text('Book a site Visit',style: TextStyle(
                                                    color: _hover1 ? Colors.white:Colors.black,
                                                  ),),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 30,),
                                          Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.white
                                              ),
                                              child: SocialMedia()),
                                        ],
                                      )
                                    ],
                                  ),
                                ),

                              ],
                            )

                        ),



                        Container(
                          height: 60,
                          child: Row(
                            children: menuList.map((e) => Padding(
                              padding: const EdgeInsets.only(left: 40.0),
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
                                  }else {

                                    tapController.showloader();
                                    html.window.history.pushState(
                                        null, '', "/${e.urlend}");
                                    maintapController.changeView();
                                    maintapController.updatee();
                                  }
                                  // setState(() {});
                                },
                                child: Text("${e.label}",style: TextStyle(
                                  // fontWeight: FontWeight.w600,
                                  color: maintapController.getView() == e.urlend? Colors.pinkAccent : _containerTextColor,
                                  letterSpacing: 2,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ),),
                              ),
                            )).toList()
                          ),
                        ),

                      ],
                    ),
                  ),

                ],
                            );
        }
      ),
    );
  }
}


/*KeyboardScrollView(
            scrollStep: 50.0,  // Optional: customize scroll step
            child: Stack(
              children: [

                SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    controller: _scrollController,
                    child: tapController.changeView()
                ),

                Container(
                  height: newheight,
                  color: _containerColor,
                  margin: EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [

                      hide ?SizedBox() :Container(
                          width: MediaQuery.of(context).size.width,
                          decoration:BoxDecoration(
                              color: Colors.white
                          ),
                          height: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/logo.jpg"),
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.watch_later,color: Color(0xFF140354),),
                                        SizedBox(width: 20,),
                                        Text('09:00AM - 05:00PM',style: GoogleFonts.poppins(
                                          // fontWeight: FontWeight.w700, // Bold weight
                                          // fontStyle: FontStyle.italic, // Italic style
                                          // fontSize: 24,
                                            color: Colors.black
                                        ))
                                      ],
                                    ),
                                    VerticalDivider(thickness: 1,color: Colors.black12,),
                                    Row(
                                      children: [
                                        Icon(Icons.call,color: Color(0xFF140354),),
                                        SizedBox(width: 20,),
                                        Text('+254 716 544 543',style: GoogleFonts.poppins(
                                            color: Colors.black
                                        ))
                                      ],
                                    ),
                                    SizedBox(width: 30,),
                                    Column(
                                      children: [
                                        MouseRegion(
                                          onEnter: (_){
                                            setState(() {
                                              _hover1 = true;
                                            });
                                          },
                                          onExit: (_){
                                            setState(() {
                                              _hover1 = false;
                                            });
                                          },

                                          child: InkWell(
                                            onTap: (){
                                              launchwhtsapp("Hello, I would like to visit some of your property sites");
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: _hover1 ? Color(0xFF140354):Colors.blueAccent.withOpacity(0.1),
                                                // border: Border.all(width: 1)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 40),
                                                child: Text('Book a site Visit',style: TextStyle(
                                                  color: _hover1 ? Colors.white:Colors.black,
                                                ),),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 30,),
                                        Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.white
                                            ),
                                            child: SocialMedia()),
                                      ],
                                    )
                                  ],
                                ),
                              ),

                            ],
                          )

                      ),



                      Container(
                        height: 60,
                        child: Row(
                            children: menuList.map((e) => Padding(
                              padding: const EdgeInsets.only(left: 40.0),
                              child: InkWell(
                                onTap: ()async{
                                  if(e.urlend == "virtualtour"){
                                    final Uri uri = Uri.parse("${auth.url}/output/index.html");
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(
                                        uri,
                                        mode: LaunchMode.externalApplication, // Ensures a new tab is opened
                                      );
                                    } else {
                                      throw "Could not launch $uri";
                                    }
                                  }else {

                                    tapController.showloader();
                                    html.window.history.pushState(
                                        null, '', "/${e.urlend}");
                                    maintapController.changeView();
                                    maintapController.updatee();
                                  }
                                  // setState(() {});
                                },
                                child: Text("${e.label}",style: TextStyle(
                                  // fontWeight: FontWeight.w600,
                                    color: maintapController.getView() == e.urlend? Colors.pinkAccent : _containerTextColor,
                                    letterSpacing: 2,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),),
                              ),
                            )).toList()
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            )
          ); */