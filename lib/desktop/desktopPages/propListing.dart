import 'package:famlimited/controller.dart';
import 'package:famlimited/desktop/desktopPages/footer.dart';
import 'package:famlimited/desktop/desktopPages/listing.dart';
import 'package:flutter/material.dart';
import 'dart:html';
import '../../reusables/reuseconf.dart';
import 'dart:html' as html;


class PropListing extends StatefulWidget {

  PropListing({super.key,});

  @override
  State<PropListing> createState() => _PropListingState();
}

class _PropListingState extends State<PropListing> {

  List props = [];
  // Listing(properties: props,crossCount: 3,),
  getProperties()async{
    print('getting');
    var resu = await auth.getvalues("property/proplisting/list?type=Props");
    setState(() {
      props = resu;
    });
  }

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

    return Stack(
      children: [
        Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height* 0.6,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg4.webp"), // Specify the image asset
                    fit: BoxFit.cover,  // Adjust the image fit
                  ),
                ),
                child: Container(
                  color: Colors.black12,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Listing(properties: props,crossCount: 3,),
              DektopFooter()
            ],
          ),
        Padding(
          padding:  EdgeInsets.only(
              left: (MediaQuery.of(context).size.height * 0.2).toDouble(),
              right: (MediaQuery.of(context).size.height * 0.2).toDouble(),
              top: (MediaQuery.of(context).size.height * 0.4).toDouble()),

          child: Container(
              height: 65,
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
                          color: Colors.indigo.shade800
                      ),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0,right: 10),
                            child: Text('Search',style: TextStyle(color: Colors.white),),
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
