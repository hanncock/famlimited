import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:html' as html;
import '../../controller.dart';
import '../../desktop/desktopPages/footer.dart';
import '../../reusables/reuseconf.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../ytube.dart';


class MobilePropDetail extends StatefulWidget {
  const MobilePropDetail({super.key});

  @override
  State<MobilePropDetail> createState() => _MobilePropDetailState();
}

class _MobilePropDetailState extends State<MobilePropDetail> {

  var propdetails;
  List images = [];
  var currImgIndx = 0;

  List ammenities = [
    "Smoke Alarms","Dedicated Security personell",
    "Seciruty Camersa","Paved Cabros Roads","First Aid Kits"
  ];


  getProp()async{
    String currentUrl = html.window.location.href;
    List<String> parts = currentUrl.split('/');

    var resu = await auth.getvalues("property/proplisting/list?id=${parts[4]}");
    images = jsonDecode(resu[0]['images']);
    propdetails = resu;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getProp();
  }

  @override
  Widget build(BuildContext context) {

    html.window.onPopState.listen((event) {
      TapController().getView();
      html.window.history.pushState(TapController().getView(), '', html.window.location.href);
      TapController().changeView();
    });

    return propdetails == null ? Text(''):
    Container(
      height: MediaQuery.of(context).size.height * 0.93,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              // margin: EdgeInsets.symmetric(horizontal:5),
              height: 400,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage("${auth.imgurl}/${images[currImgIndx]}"),
                  fit: BoxFit.cover, // Adjust the image fit
                ),
              ),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){

                            if(currImgIndx >= 0){
                              setState(() {
                                currImgIndx = 0;
                              });
                            }else{
                              setState(() {
                                currImgIndx --;
                              });

                            }
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor:Colors.black26,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.navigate_before_outlined,size: 60,color: Colors.white,),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){

                            if (currImgIndx < images.length - 1) {
                              setState(() {
                                currImgIndx++;
                              });
                            } else {
                              setState(() {
                                currImgIndx = 0; // Reset to 0 to loop back to the first image
                              });
                            }
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor:Colors.black26,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.navigate_next_outlined,size: 60,color: Colors.white,),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            SingleChildScrollView(
              primary: false,
              scrollDirection: Axis.horizontal,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: images.asMap().entries.map((entry) {
                 int index = entry.key; // The index of the current item
                 String e = entry.value; // The current image value

                 return InkWell(
                   onTap: () {
                     setState(() {
                       currImgIndx = index; // Update to use the index
                     });
                   },
                   child: Container(
                     margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       image: DecorationImage(
                         image: NetworkImage("${auth.imgurl}/${e}"),
                         fit: BoxFit.cover,
                       ),
                     ),
                     width: 120,
                     height: 80,
                   ),
                 );
               }).toList(),
             )
            ),
            Divider(thickness: 1,color: Colors.black12,),
            SizedBox(height: 5,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('${propdetails[0]['propName']}',
                              style: GoogleFonts.kanit(
                                fontWeight: FontWeight.w500, // Regular weight
                                fontStyle: FontStyle.normal, // Normal (not italic)
                                fontSize: 24,
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${formatCurrency(int.parse(propdetails[0]['price'] ?? 0))}',
                              style: GoogleFonts.kanit(
                                color: Colors.green,
                                fontWeight: FontWeight.w500, // Regular weight
                                fontStyle: FontStyle.normal, // Normal (not italic)
                                fontSize: 20,
                              )),
                        ],
                      ),
                      Divider(thickness: 1,color: Colors.black12,),
                      Row(
                        children: [
                          Icon(Icons.pin_drop_outlined),
                          Text('${propdetails[0]['location']}')
                        ],
                      ),
                      SizedBox(height: 10,),
                      Container(
                        child: Text('${propdetails[0]['description']}',
                          softWrap: true,
                          style:TextStyle(
                              letterSpacing: 1,
                              fontSize: 15
                          ) ,),
                      ),
                      SizedBox(height: 10,),
                      Divider(thickness: 1,color: Colors.black12,),
                      SizedBox(height: 10,),
                      (propdetails[0]['videolink'] == null || propdetails[0]['videolink'].isEmpty )  ? Text(''):Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Divider(thickness: 1,color: Colors.black12,),
                            SizedBox(height: 20,),
                            Text('Video',
                                style: GoogleFonts.kanit(
                                  fontWeight: FontWeight.w500, // Regular weight
                                  fontStyle: FontStyle.normal, // Normal (not italic)
                                  fontSize: 24,
                                )
                            ),
                            Container(
                                height:400,
                                width: MediaQuery.of(context).size.width,
                                decoration:BoxDecoration(
                                    color:Colors.blue.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                // child: Text('soke'),
                                // https://www.youtube.com/watch?v=N14jz8ptDx0&pp=ygUKZmFtbGltaXRlZA%3D%3D
                                // child:VideoApp(videoUrl: 'https://www.youtube.com/watch?v=7ESr75F-k3U')
                                child:IframeScreen(url: '${propdetails[0]['videolink']}')
                              // child:YoutubePlayer(videoUrl: '',)
                            ),

                          ]

                      ),
                      SizedBox(height: 10,),
                      // Divider(thickness: 1,color: Colors.black12,),
                      // SizedBox(height: 10,),
                      /*Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ammenities And Features',
                            style: GoogleFonts.kanit(
                              fontWeight: FontWeight.w500, // Regular weight
                              fontStyle: FontStyle.normal, // Normal (not italic)
                              fontSize: 24,
                            ),
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: ammenities.map((item){
                                return Row(
                                  children: [
                                    Icon(Icons.circle,size: 5,),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('${item}'),
                                    ),
                                  ],
                                );
                              }).toList()
                          )
                        ],
                      )*/
                    ],
                  ),
                ),

                Container(
                  child: Container(
                      decoration: BoxDecoration(
                          // color: Colors.black12.withOpacity(0.5)
                      ),
                      // height: MediaQuery.of(context).size.height * 0.5,
                      // width: MediaQuery.of(context).size.width * 0.4,
                      child: Center(child: InkWell(
                        onTap: (){
                          launchwhtsapp("Hello, What i would like an inquiry on ${propdetails[0]['propName']}");
                        },

                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.indigo.shade800
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20.0),
                              child: Text('Reach Out',style: TextStyle(color: Colors.white, ),),
                            )),
                      ))),
                ),
                SizedBox(height: 10),

                SizedBox(width: 50,),
              ],
            ),

            DektopFooter(mobile: "true",)
          ],
        ),
      ),
    );
  }
}
