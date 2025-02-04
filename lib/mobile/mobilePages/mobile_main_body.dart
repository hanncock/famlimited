import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../controller.dart';
import '../../desktop/desktopPages/footer.dart';
import '../../desktop/desktopPages/listing.dart';
import '../../reusables/reuseconf.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html' as html;
class Mobilemainbody extends StatefulWidget {
  const Mobilemainbody({super.key});

  @override
  State<Mobilemainbody> createState() => _MobilemainbodyState();
}

class _MobilemainbodyState extends State<Mobilemainbody> {

  var imageInView;
  int _currentImageIndex = 0;

  List props = [];

  getProperties()async{
    var resu = await auth.getvalues("property/proplisting/list?type=Props");
    setState(() {
      props = resu;
    });
  }

  chnagebg(){
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % images.length;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    chnagebg();
    getProperties();
  }


  @override
  Widget build(BuildContext context) {
    html.window.onPopState.listen((event) {
      TapController().getView();
      html.window.history.pushState(TapController().getView(), '', html.window.location.href);
      TapController().changeView();
    });
    return Container(
      child: Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/${images[_currentImageIndex]}"), // Specify the image asset
                      fit: BoxFit.cover,  // Adjust the image fit
                    ),
                  ),
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),
                  height: 700,
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
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: images.map((e) => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Container(
                                    width: 60,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage("assets/images/${e}"), // Specify the image asset
                                        fit: BoxFit.cover,  // Adjust the image fit
                                      ),
                                    ),),
                                )).toList(),
                              )
                          )
                        ],
                      ),
                    ),
                  )
              ),
              SizedBox(height: 10,),
              Container(
                child: CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                    ),
                    items: services
                        .map((item) => Container(
                      height: 150,
                      width: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage("assets/images/${item['image']}"),
                          fit: BoxFit.cover,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text('${item["serviceTitle"]}',
                                  style: TextStyle(fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))
                        .toList()
                ),),
              Container(
                  child: Column(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Divider(thickness: 0.1,color: Colors.grey.shade800,)),
                      Text('TOP SELLING',style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      )),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Divider(thickness: 0.1,color: Colors.grey.shade800,)),
                      Listing(properties: props,crossCount: 1,mobile: "true",)
                    ],
                  )
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.1),

                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/images/whysus.jpg"), // Specify the image asset
                    fit: BoxFit.cover,  // Adjust the image fit
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('WHY CHOOSE FAM LIMITED',style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w800, // Regular weight
                            fontStyle: FontStyle.normal, // Normal (not italic)
                            fontSize: 20,
                            letterSpacing: 1
                        ),),
                      ],
                    ),
                    Column(
                      children: whysus.map((e) => Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width * 0.85,
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
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: Text('${e['descr']}',softWrap: true,style: TextStyle(fontSize: 14),),
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
              ),
              SizedBox(height: 10,),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("assets/images/farmoutreach.jpeg"), // Specify the image asset
                    fit: BoxFit.fill,  // Adjust the image fit
                  ),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  color: Colors.black.withOpacity(0.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Preparing for an outreach... !!! \n Look no further FAM Limited got you covered',
                                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w800,color: Colors.white),textAlign: TextAlign.center,),
                        
                            ),
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.real_estate_agent_outlined,color: Colors.indigo.shade800,size: 30,),
                                    SizedBox(width: 10,),
                                    Text('Fam Outreach',style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.campaign,color: Colors.indigo.shade800,size: 30,),
                                    SizedBox(width: 10,),
                                    Text('Trailer Events',style: TextStyle(color: Colors.white),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.add_road_outlined,color: Colors.indigo.shade800,size: 30,),
                                    SizedBox(width: 10,),
                                    Text('RoadShows & logistics',style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              // color: Colors.black12.withOpacity(0.5)
                          ),
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
                                  child: Text('Book a fam outreach',style: TextStyle(color: Colors.white,fontSize: 14),),
                                )),
                          ))),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
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
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Your Home Ownership Journey Begins Here',style: TextStyle(fontSize: 24,color: Colors.white),
                        textAlign: TextAlign.center,
                        softWrap: true,),
                      SizedBox(height: 14,),
                      Text('We offer luxury and convinience all in one.Browse to find your dream home!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),softWrap: true,),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              DektopFooter(mobile: "true",)
            ],
          ),
        ),
      ),
    );
  }
}
