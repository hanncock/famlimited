import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html' as html;
import 'package:get/get.dart';
import '../../controller.dart';
import '../../reusables/reuseconf.dart';

class Listing extends StatefulWidget {
  String ? mobile;
  String ? showdetail;
  int crossCount;
  List properties;
  Listing({super.key,required this.properties,required this.crossCount,this.mobile,this.showdetail});

  @override
  State<Listing> createState() => _ListingState();
}

class _ListingState extends State<Listing> {

  String formatPrice(int price) {
    if (price >= 1000000) {
      // return '${(price / 1000000).toStringAsFixed(1)} M';  // 2.5M
      return '${(price / 1000000).toStringAsFixed(2)} M';  // 2.5M
    } else if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)} K';  // 250K
    } else {
      return price.toString();  // If less than 1K, return as is
    }
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
  Widget build(BuildContext context) {

    html.window.onPopState.listen((event) {
      TapController().getView();
      html.window.history.pushState(TapController().getView(), '', html.window.location.href);
      TapController().changeView();
    });



    return GetBuilder<TapController>(
        builder: (tapController3) {
          return Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.8,
            child: GridView.builder(
              primary: false,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.crossCount, // Two items per row
                crossAxisSpacing: 10, // Space between items horizontally
                mainAxisSpacing: 10, // Space between items vertically
              ),
              itemCount: widget.properties.length, // Total number of items
              itemBuilder: (context, index) {
                var images = jsonDecode(widget.properties[index]['images']);
                double scale = _scaleMap[index] ?? 1.0;
                return InkWell(
                  onTap: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => PropDetail(propdetail: [widget.properties[index]], images: images,) ));
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => PropDetail(propdetail: widget.properties[index], images: images,) ));
                    // html.window.history.pushState(null, '', "/property/proplisting/id=${widget.properties[index]['id']}");
                    html.window.history.pushState(null, '', "/property/${widget.properties[index]['id']}");
                    tapController3.changeView();
                    // setState(() {});
                    tapController3.updatee();
                  },

                  child: Container(
                    height: widget.mobile == true ? 280: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.black12)
                    ),
                    child: Container(
                      height: widget.mobile == true ? 280: MediaQuery.of(context).size.height * 0.25,
                      width: 550,
                      // duration: Duration(milliseconds: 300),
                      // Smooth animation
                      // curve: Curves.easeInOut,
                      // Easing for the transition
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("${auth.imgurl}/${images[0]}"),
                          fit: BoxFit.fitHeight, // Adjust the image fit
                        ),
                      ),
                      transform: Matrix4.identity()
                        ..scale(scale, scale),
                      // Apply the scale transformation
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          widget.properties[index]['featured'] == 'YES' ? SizedBox() :Container(
                              decoration: BoxDecoration(
                                // color: Colors.green,
                                  color: Colors.indigo.shade800,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20)
                                  )
                              ),
                              width: 100,
                              height: 40,
                              // child: Center(child: Text('${ double.parse((int.parse(widget.properties[index]['price']) / 1000000).toStringAsFixed(2))  } ',
                              child: Center(child: Text('${ formatPrice(int.parse(widget.properties[index]['price']))} ',
                                style: GoogleFonts.kanit(
                                  // fontWeight: FontWeight.w700, // Bold weight
                                  // fontStyle: FontStyle.italic, // Italic style
                                    fontSize: 20,
                                    color: Color(0xFFFFFFFF)
                                ),/*TextStyle(
                                color: Colors.white, fontSize: 20),*/
                              ))),
                          widget.properties[index]['featured'] == 'YES' ?Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black26,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('C O M I N G  S O O N',
                                    style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 2,
                                        fontSize: 24
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ): SizedBox(),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.indigo.shade800.withOpacity(0.5)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text('${widget.properties[index]['propName'].toUpperCase()}', style: GoogleFonts.kanit(
                                      fontWeight: FontWeight.w500, // Regular weight
                                      fontStyle: FontStyle.normal, // Normal (not italic)
                                      fontSize: 20,
                                      color: Colors.white
                                  ),
                                    /*TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)*/
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
    );
  }
}