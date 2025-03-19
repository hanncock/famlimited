import 'dart:convert';

import 'package:famlimited/dispgal.dart';
import 'package:famlimited/reusables/reuseconf.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'desktop/desktopPages/footer.dart';

class Gallery extends StatefulWidget {
  final String ? mobile;
  final int crossCount;
  const Gallery({super.key,this.mobile, required this.crossCount});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {

  List gallery_images = [];


  /*getImages()async{
    var resu = await auth.getvalues("property/gallery/list");
    setState(() {
      gallery_images = resu;
    });
    print(gallery_images);
  }*/

  getImages()async{
    var resu = await auth.getvalues("property/proplisting/list");
    setState(() {
      gallery_images  = resu;
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
      height: MediaQuery.of(context).size.height * 0.93,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: widget.mobile == "true"?  EdgeInsets.all(10.0) :EdgeInsets.only(top: 280),
              child: Center(
                /* child: Column(
                  children: List.generate(gallery_images.length, (index){
                    var e = gallery_images[index];
                    List<dynamic> img = e["images"] == null ? [] : jsonDecode(gallery_images[index]['images']);
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DispGal(data: gallery_images[index]) ));
                        },
                        child: Container(
                          width: 400,
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("${auth.imgurl}/${img[0]}"),
                                // image: AssetImage(
                                //     "${widget.properties[index]['images'][0]}"),
                                // Specify the image asset
                                fit: BoxFit.fitWidth, // Adjust the image fit
                              )),
                          child: Container(
                              color: Colors.black12,
                              child: Center(child: Text('${e['propName']}',
                                style: TextStyle(color: Colors.white,
                                  fontSize: 20,
                                  letterSpacing: 1
                                ),))),
                        ),
                      ),
                    );
                  }),
                )*/
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.8,
                    child: GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      /*gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: widget.crossCount, // Two items per row
                        crossAxisSpacing: 10, // Space between items horizontally
                        mainAxisSpacing: 10, // Space between items vertically
                      ),*/
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: widget.mobile == "true"?  1 : widget.crossCount,
                        childAspectRatio: widget.mobile == "true"? MediaQuery.of(context).size.width /2/150 :MediaQuery.of(context).size.width /2/500 , // You can modify this to change the ratio
                      ),
                      itemCount: gallery_images.length, // Total number of items
                      itemBuilder: (context, index) {
                        var e = gallery_images[index];
                        List<dynamic> img = e["images"] == null ? [] : jsonDecode(gallery_images[index]['images']);
                        double scale = _scaleMap[index] ?? 1.0;
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DispGal(data: gallery_images[index]) ));
                          },
                          child: Container(
                            // height: widget.mobile == true ? 280: MediaQuery.of(context).size.height * 0.3,
                            // height: 100,
                            // decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(10),
                            //     border: Border.all(width: 1, color: Colors.black12)
                            // ),

                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("${auth.imgurl}/${img[0]}"),
                                // image: AssetImage(
                                //     "${widget.properties[index]['images'][0]}"),
                                // Specify the image asset
                                fit: BoxFit.fitWidth, // Adjust the image fit
                              ),
                            ),
                            child: Container(
                                color: Colors.black12,
                                child: Center(child: Text('${e['propName']}',
                                  style: TextStyle(color: Colors.white,
                                      fontSize: 20,
                                      letterSpacing: 1
                                  ),))),
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
