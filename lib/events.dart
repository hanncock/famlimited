import 'dart:convert';

import 'package:famlimited/dispgal.dart';
import 'package:famlimited/reusables/loading.dart';
import 'package:famlimited/reusables/reuseconf.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'desktop/desktopPages/footer.dart';

class Events extends StatefulWidget {
  final String ? mobile;
  final int crossCount;
  const Events({super.key,this.mobile, required this.crossCount});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {

  List Events_images = [];

  getImages()async{
    var resu = await auth.getvalues("property/proplisting/list?type=Event");
    setState(() {
      Events_images  = resu;
    });
  }


  Map<int, double> _scaleMap = {};

  // Function to handle hover enter for a specific cell
  void _onEnter(int index) {
    setState(() {
      _scaleMap[index] = 1.01; // Zoom in effect for the cell at `index`
    });
  }

  // Function to handle hover exit for a specific cell
  void _onExit(int index) {
    setState(() {
      _scaleMap[index] = 1.0; // Reset to original size for the cell at `index`
    });
  }



  @override
  void initState(){
    super.initState();
    getImages();
  }


  @override
  Widget build(BuildContext context) {
    return  Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // SizedBox(height: 100,),
            Events_images.isEmpty ?
               Container(
                 height: 500,
                 child: Center(
                   child: LoadingSpinCircle(),
                   /*child: Text('Events Coming Soon',style: TextStyle(
                     fontSize: 20
                   ),),*/
                 ),
               ) :Padding(
              padding: widget.mobile == "true"?  EdgeInsets.all(10.0) :EdgeInsets.only(top: 280),
              child: Center(

                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.8,
                    child: GridView.builder(
                      primary: false,
                      shrinkWrap: true,
                     /* gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: widget.crossCount, // Two items per row
                        crossAxisSpacing: 10, // Space between items horizontally
                        mainAxisSpacing: 10, // Space between items vertically
                      ),*/
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: widget.mobile == "true"?  1 : widget.crossCount,
                        childAspectRatio: widget.mobile == "true"? MediaQuery.of(context).size.width /2/150 :MediaQuery.of(context).size.width /2/200 , // You can modify this to change the ratio
                      ),
                      itemCount: Events_images.length, // Total number of items
                      itemBuilder: (context, index) {
                        var e = Events_images[index];
                        List<dynamic> img = e["images"] == null ? [] : jsonDecode(Events_images[index]['images']);
                        double scale = _scaleMap[index] ?? 1.0;
                        return InkWell(
                          onTap: (){
                            e['featured'] == 'YES'? setState(() {

                            }) : Navigator.push(context, MaterialPageRoute(builder: (context) => DispGal(data: Events_images[index]) ));
                          },
                          child: Container(
                            // height: widget.mobile == true ? 280: MediaQuery.of(context).size.height * 0.3,
                            // height: 100,
                            // decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(10),
                            //     border: Border.all(width: 1, color: Colors.black12)
                            // ),

                            /*decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("${auth.imgurl}/${img[0]}"),
                                // image: AssetImage(
                                //     "${widget.properties[index]['images'][0]}"),
                                // Specify the image asset
                                fit: BoxFit.fitWidth, // Adjust the image fit
                              ),
                            ),*/
                            decoration: BoxDecoration(
                              color: (img.isEmpty || img[0].isEmpty) ? Colors.blueAccent.withOpacity(0.5) : null,
                              image: (img.isNotEmpty && img[0].isNotEmpty)
                                  ? DecorationImage(
                                image: NetworkImage("${auth.imgurl}/${img[0]}"),
                                fit: BoxFit.fitWidth,
                              )
                                  : null,
                            ),

                            child: Container(
                                color: Colors.black26,
                                child: Center(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('${e['propName']}',
                                      style: TextStyle(color: Colors.white,
                                          fontSize: 20,
                                          letterSpacing: 2,
                                          fontWeight: FontWeight.w800
                                      ),),
                                    e['featured'] == 'NO' ? SizedBox() : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Coming Soon',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              letterSpacing: 1,
                                            fontWeight: FontWeight.w200
                                          )
                                      ),
                                    )
                                  ],
                                ))),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            widget.mobile == "desktop" ? DektopFooter() : DektopFooter(mobile: "true",),
          ],
        ),
      ),
    );
  }
}
