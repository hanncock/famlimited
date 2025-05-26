import 'dart:async';
import 'dart:convert';
// import 'package:famlimited/reusables/txtform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import '../../controller.dart';
// import '../../maps.dart';
import '../../reusables/reuseconf.dart';
import 'footer.dart';
import 'listing.dart';
import 'package:get/get.dart';
import 'dart:html' as html;
// import 'dart:html';
// import 'package:url_launcher/url_launcher.dart';



class DesktopContents extends StatefulWidget {
  const DesktopContents({super.key});

  @override
  State<DesktopContents> createState() => _DesktopContentsState();
}

class _DesktopContentsState extends State<DesktopContents> with SingleTickerProviderStateMixin{





  int _currentImageIndex = 0;
  List props = [];
  chnagebg(){
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % images.length;
      });
    });
  }

  getHomeImages() async {
    var resu = await auth.getvalues("property/homeimage/list");
    if (resu is List) {
      for (int i = 0; i < resu.length; i++) {
        var to_dcd = jsonDecode(resu[i]['images']);
        hmImages.add(to_dcd[0]);
      }
    }
  }

  getProperties()async{
    var resu = await auth.getvalues("property/proplisting/list?type=Props");
    setState(() {
      props = resu;
    });
  }

  late AnimationController _controller;
  late Animation<double> _animation;

  bool _hover2 = false;
  List hmImages = [];
  bool _hover3 = false;


  @override
  void initState() {

    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 775)
    );
    _animation = Tween<double>(begin: 920.0,end: 0.0).animate(
        CurvedAnimation(parent: _controller,
            curve: Curves.easeIn));

    getProperties().whenComplete((){
      // getHomeImages().whenComplete((){
      chnagebg();
      // });
    });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    /* window.onPopState.listen((event) {
      // Code to handle the back button press
      print('Back button pressed');

      // TapController().changeView();

    });*/

    html.window.onPopState.listen((event) {
      TapController().getView();
      html.window.history.pushState(TapController().getView(), '', html.window.location.href);
      TapController().changeView();
    });

    return Stack(
      children: [
        Column(
          children: [
            // hmImages.isEmpty?
            Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("/images/${images[_currentImageIndex]}"), // Specify the image asset
                    fit: BoxFit.cover,  // Adjust the image fit
                  ),
                ),
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child:Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(''),
                        Container(
                            height: MediaQuery.of(context).size.height * 0.48,
                            decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:  SingleChildScrollView(
                              primary: false,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: images.map((e) => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 3),
                                  child: Container(
                                    width: 80,
                                    height: (MediaQuery.of(context).size.height * 0.5)/5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage("assets/images/${e}"), // Specify the image asset
                                        fit: BoxFit.cover,  // Adjust the image fit
                                      ),
                                    ),),
                                )).toList(),
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                )
            )
            /* :Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("${auth.imgurl}/${hmImages[_currentImageIndex]}"), // Specify the image asset
                    fit: BoxFit.cover,  // Adjust the image fit
                  ),
                ),

                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
                height: MediaQuery.of(context).size.height ,
                width: MediaQuery.of(context).size.width,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height * 0.57,
                              decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child:  SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: hmImages.map((e) => Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      width: 80,
                                      height: (MediaQuery.of(context).size.height * 0.5)/4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          // image: AssetImage("assets/images/${e}"), // Specify the image asset
                                          image: NetworkImage("${auth.imgurl}/${e}"), // Specify the image asset
                                          fit: BoxFit.cover,  // Adjust the image fit
                                        ),
                                      ),),
                                  )).toList(),
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  ],
                )
            )*/,

            Padding(
              padding:  EdgeInsets.only(top: (MediaQuery.of(context).size.height * 0.12).toDouble()),
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: services.map((e) =>  Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: AssetImage("assets/images/${e["image"]}"), // Specify the image asset
                              fit: BoxFit.cover,  // Adjust the image fit
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2), // Shadow color
                                offset: Offset(4, 4), // Shadow offset (x, y)
                                blurRadius: 8, // Blur effect
                                spreadRadius: 2, // Spread effect
                              ),
                            ],
                          ),
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                color: Colors.grey.withOpacity(0.5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text('${e["serviceTitle"]}',
                                        style: TextStyle(fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )).toList(),

                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/key.png"), // Specify the image asset
                      fit: BoxFit.cover,  // Adjust the image fit
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Column(
                  children: [
                    Text('Global Real Investment',style: GoogleFonts.poppins(
                        height: 1.5,
                        fontSize: 30,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold
                    )),
                    SizedBox(height: 30,),
                    Container(
                      child: DefaultTabController(
                          length: 3,
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TabBar(
                                    tabs:[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('ABOUT US'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('WHY CHOOSE US'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('OUR MISSION'),
                                      ),
                                    ]
                                ),
                              ),
                              Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width * 0.4,

                                child: TabBarView(
                                  children: [
                                    Center(
                                      child: Text('Fam limited is committed to bringing our clients the best in value and quality real estate investments. We are passionate about real estate and sharing the best investment opportunities with you.',
                                        softWrap: true,
                                      ),
                                    ),
                                    Center(child: Text('We are proud to offer excellent quality and value for money in our properties, which give you the chance to experience serenity and luxury in an authentic and exciting way')),
                                    Center(child: Text('Our mission is to provide the ultimate Real investments solutions while becoming a one-stop shop for every real estate investor available in the industry'))

                                  ],
                                ),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GetBuilder<TapController>(
                                      builder: (maintapController) {
                                        return MouseRegion(
                                          onEnter: (_){
                                            setState(() {
                                              _hover2 = true;
                                            });
                                          },
                                          onExit: (_){
                                            setState(() {
                                              _hover2 = false;
                                            });
                                          },

                                          child: InkWell(
                                            onTap:(){
                                              html.window.history.pushState(null, '', "/contactus");
                                              maintapController.changeView();
                                              maintapController.updatee();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: _hover2 ? Color(0xFF140354):Colors.transparent,
                                                  border: Border.all(width: 1)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 40),
                                                child: Text('Get in Touch',style: TextStyle(
                                                  color: _hover2 ? Colors.white:Colors.black,
                                                ),),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                  ),
                                  SizedBox(width: 20,),
                                  GetBuilder<TapController>(
                                      builder: (maintapController) {
                                        return MouseRegion(
                                          onEnter: (_){
                                            setState(() {
                                              _hover3= true;
                                            });
                                          },
                                          onExit: (_){
                                            setState(() {
                                              _hover3 = false;
                                            });
                                          },

                                          child: InkWell(
                                            onTap:(){
                                              html.window.history.pushState(null, '', "/aboutus");
                                              maintapController.changeView();
                                              maintapController.updatee();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: _hover3 ? Color(0xFF140354):Colors.transparent,
                                                  border: Border.all(width: 1)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 40),
                                                child: Text('Read More',style: TextStyle(
                                                  color: _hover3 ? Colors.white:Colors.black,
                                                ),),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                  ),
                                ],
                              )

                            ],
                          )
                      ),
                    )

                  ],
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
                child: Column(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Divider(thickness: 0.1,color: Colors.grey.shade800,)),
                    Text('UPCOMING',style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Divider(thickness: 0.1,color: Colors.grey.shade800,)),
                    Listing(properties: props,crossCount: 3,showdetail:"false"),
                  ],
                )
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.12,),
            Container(
              color: Colors.blueAccent.withOpacity(0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 10,),
                  Container(
                    width:MediaQuery.of(context).size.width * 0.45,
                    height: 700,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)
                      ),
                      image: DecorationImage(
                        image: AssetImage("assets/images/whysus.jpg"), // Specify the image asset
                        fit: BoxFit.cover,  // Adjust the image fit
                      ),
                    ),
                    child: Container(
                      width:MediaQuery.of(context).size.width * 0.45,
                      height: 700,
                      color: Colors.black12,
                      child: Center(
                        child: Text('F A M \n L I M I T E D',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 50,color: Colors.white,
                          ),),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            // Text('Our Benefit',style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('WHY CHOOSE FAM LIMITED',style: GoogleFonts.kanit(
                                  fontWeight: FontWeight.w800, // Regular weight
                                  fontStyle: FontStyle.normal, // Normal (not italic)
                                  fontSize: 30,
                                ),),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Text("\n",softWrap: true,
                                style: GoogleFonts.dancingScript(
                                    fontSize: 16
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: whysus.map((e) => Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(top: 10),
                            width: MediaQuery.of(context).size.width * 0.35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                    width: 100,
                                    child: Icon(Icons.add_a_photo,color: Colors.blue,)),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 10.0),
                                        child: Text('${e['title']}',style: GoogleFonts.poppins(
                                            fontSize: 22,letterSpacing: 2,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      ),
                                      SizedBox(height: 20,),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10.0),
                                        child: Text('${e['descr']}',softWrap: true,style: TextStyle(fontSize: 16),),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )).toList(),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            /* {
              "serviceTitle":"Farm Outreach",
              "image":"farmoutreach.jpeg"
            },*/

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Preparing Outdoor Events... !!! \n Preparing for an outreach... !!! \n Look no further FAM Limited got you covered',
                            style: TextStyle(fontSize: 25,fontWeight: FontWeight.w800),textAlign: TextAlign.center,),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.real_estate_agent_outlined,color: Colors.indigo.shade800,size: 30,),
                                  SizedBox(width: 30,),
                                  Text('Fam Outreach',),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.campaign,color: Colors.indigo.shade800,size: 30,),
                                  SizedBox(width: 30,),
                                  Text('Trailer Events',),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.add_road_outlined,color: Colors.indigo.shade800,size: 30,),
                                  SizedBox(width: 30,),
                                  Text('RoadShows & logistics',),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                /*Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ContainerWithFourImages())*/

                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage("assets/images/farmoutreach.jpeg"), // Specify the image asset
                      fit: BoxFit.fitWidth,  // Adjust the image fit
                    ),
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.5)
                      ),
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Center(child: InkWell(
                        onTap: (){
                          launchwhtsapp("Hello, What i would like an inquiry on the outreach booking charges");
                        },

                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.indigo.shade800
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20.0),
                              child: Text('Book a fam outreach',style: TextStyle(color: Colors.white,fontSize: 20),),
                            )),
                      ))),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
              height: 400,
              decoration: BoxDecoration(

                image: DecorationImage(
                  image: AssetImage("assets/images/${images[_currentImageIndex]}"), // Specify the image asset
                  fit: BoxFit.cover,  // Adjust the image fit
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Your Home Ownership Journey Begins Here',style: TextStyle(fontSize: 30,color: Colors.white),),
                        SizedBox(height: 20,),
                        Text('We offer luxury and convinience all in one.Browse our website to find your dream home!',
                          style: TextStyle(color: Colors.white),),
                        SizedBox(height: 20,),
                        InkWell(
                          onTap: (){
                            launchwhtsapp("Hello, What i would like an to have a site visit ");
                          },
                          child: Container(
                            height:50,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.indigo[900]
                            ),
                            child: Center(child: Text('Book a site visit today',style: TextStyle(color: Colors.white,fontSize: 14),)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),

            SizedBox(height: 20,),
            /*Container(
                height:400,
                width: MediaQuery.of(context).size.width,
                child: GoogleMapEmbed(
                  height: 400,
                  width: double.infinity,
                )),*/

            SizedBox(height: MediaQuery.of(context).size.height * 0.12,),
            DektopFooter()
          ],
        ),
        Padding(
          padding:  EdgeInsets.only(
              left: (MediaQuery.of(context).size.height * 0.2).toDouble(),
              right: (MediaQuery.of(context).size.height * 0.2).toDouble(),
              top: (MediaQuery.of(context).size.height * 0.95).toDouble()),

          child: Container(
              height: 80,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white60,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Shadow color
                    offset: Offset(4, 4), // Shadow offset (x, y)
                    blurRadius: 8, // Blur effect
                    spreadRadius: 2, // Spread effect
                  ),
                ],
              ),
              child: Row(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text("Type",style: TextStyle(color: Colors.black),),
                            Container(
                              width: 150,
                            ),
                          ],
                        ),
                        VerticalDivider(thickness: 1,color: Colors.black,),
                        Column(
                          children: [
                            Text("Location",style: TextStyle(color: Colors.black),),
                            Container(
                              width: 150,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.indigo.shade900
                      ),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0,right: 10),
                            child: Text('SEARCH',style: TextStyle(color: Colors.white),),
                          ),
                          Icon(Icons.search,color: Colors.white,)
                        ],
                      )
                  )
                ],
              )),
        ),
      ],
    );
  }
}
