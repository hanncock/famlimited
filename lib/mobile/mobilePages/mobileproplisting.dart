import 'package:famlimited/desktop/desktopPages/footer.dart';
import 'package:flutter/material.dart';

import '../../controller.dart';
import '../../desktop/desktopPages/listing.dart';
import '../../reusables/reuseconf.dart';
import 'dart:html' as html;

class MobilePropListing extends StatefulWidget {
  const MobilePropListing({super.key});

  @override
  State<MobilePropListing> createState() => _MobilePropListingState();
}

class _MobilePropListingState extends State<MobilePropListing> {

  List props = [];

  getProperties()async{
    var resu = await auth.getvalues("property/proplisting/list?type=Props");
    setState(() {
      props = resu;
    });
    print(props);
  }



  @override
  void initState(){
    super.initState();
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  // height: 80,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white60,
                    boxShadow: [
                      /*BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        offset: Offset(4, 4), // Shadow offset (x, y)
                        blurRadius: 8, // Blur effect
                        spreadRadius: 2, // Spread effect
                      ),*/
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text("Type",style: TextStyle(color: Colors.black),),
                              ],
                            ),
                            VerticalDivider(thickness: 1,color: Colors.black,),
                            Column(
                              children: [
                                Text("Location",style: TextStyle(color: Colors.black),),
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
              Divider(thickness: 0.5,),
              Listing(properties: props,crossCount: 1,mobile: "true",),
              DektopFooter(mobile: "true",),
            ],
          ),
        ),
      ),
    );
  }
}
