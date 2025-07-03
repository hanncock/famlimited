import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller.dart';
import '../../maps.dart';
import 'footer.dart';
import 'dart:html' as html;

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});






  @override
  Widget build(BuildContext context) {

    html.window.onPopState.listen((event) {
      TapController().getView();
      html.window.history.pushState(TapController().getView(), '', html.window.location.href);
      TapController().changeView();
    });
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   height: (MediaQuery.of(context).size.height * 0.1),
            //   decoration: BoxDecoration(
            //     color: Colors.black12
            //   ),
            //   child: Row(
            //     children: [
            //
            //       ],
            //   ),
            // ),

            Container(
              height: 300,
              margin: EdgeInsets.symmetric(horizontal: 0),
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage("assets/images/whysus.webp"), // Specify the image asset
                  fit: BoxFit.cover,  // Adjust the image fit
                ),
              ),
              child: Center(child: Text('Contact Us',style: TextStyle(color: Colors.white,fontSize: 20),)),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 250,
                    padding: EdgeInsets.symmetric(vertical:  10,horizontal: 20),
                    decoration: BoxDecoration(
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black12.withOpacity(0.25), // Shadow color
                        //     spreadRadius: 5,                       // Spread of the shadow
                        //     blurRadius: 10,                        // Blur radius
                        //     offset: Offset(4, 4),                  // Offset of the shadow
                        //   ),
                        // ],
                      // border: Border.all(width: 1,color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      // color: Colors.white
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.phone_android,
                            size: 80,
                            color: Color(0xFF140354),),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(thickness: 1,color: Color(0xFF140354),),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('+254 716 544 543',
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                // fontSize:25,
                                  height: 2,
                                  letterSpacing: 1,
                                  color:Colors.black,
                                  fontWeight:FontWeight.w500),
                            ),
                          ),
                        ],

                      ),
                    ),
                  ),
                  VerticalDivider(thickness: 0.5,),
                  Container(
                    width: 250,
                    padding: EdgeInsets.symmetric(vertical:  10,horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.location_history,
                            size: 83,
                            color: Color(0xFF140354),),

                          Divider(thickness: 1,color: Color(0xFF140354),),



                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('Thika super highyway exit 13 SPUR MALL 2nd floor suite S006',
                            softWrap: true,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  // fontSize:25,
                                height: 2,
                                  letterSpacing: 1,
                                  color:Colors.black,
                                  fontWeight:FontWeight.w500),
                            ),
                          ),

                        ],

                      ),
                    ),
                  ),
                  VerticalDivider(thickness: 0.5,),
                  Container(
                    width: 250,
                    padding: EdgeInsets.symmetric(vertical:  10,horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.email_outlined,
                            size: 83,
                            color: Color(0xFF140354),),

                          Divider(thickness: 1,color: Color(0xFF140354),),

                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('sales@famlimited.co.ke',

                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                // fontSize:25,
                                  height: 2,
                                  letterSpacing: 1,
                                  color:Colors.black,
                                  fontWeight:FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('info@famlimited.co.ke',
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                // fontSize:25,
                                  height: 2,
                                  letterSpacing: 1,
                                  color:Colors.black,
                                  fontWeight:FontWeight.w500),
                            ),
                          )

                        ],

                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Divider(thickness: 0.5,color: Colors.black12,),
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 250,
                    padding: EdgeInsets.symmetric(vertical:  10,horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.door_front_door_outlined,
                            size: 83,
                            color: Color(0xFF140354),),

                          Divider(thickness: 1,color: Color(0xFF140354),),

                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('Mon - Fri',
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                // fontSize:25,
                                  height: 2,
                                  letterSpacing: 1,
                                  color:Colors.black,
                                  fontWeight:FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('08:00 - 17:00',
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                // fontSize:25,
                                  height: 2,
                                  letterSpacing: 1,
                                  color:Colors.black,
                                  fontWeight:FontWeight.w500),
                            ),
                          )

                        ],

                      ),
                    ),
                  )
                ],
              ),
            ),
            // SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                  height:400,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMapEmbed(
                    height: 400,
                    width: double.infinity,
                  )),
            ),
            // SizedBox(height: MediaQuery.of(context).size.height * 0.12,),
            DektopFooter()
          ],
        ),
      ),
    );
  }
}
