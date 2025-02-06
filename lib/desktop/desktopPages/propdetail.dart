import 'dart:convert';
import 'package:famlimited/desktop/desktopPages/footer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:famlimited/reusables/reuseconf.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:html' as html;

import '../../controller.dart';
import '../../ytube.dart';




class PropDetail extends StatefulWidget {
 /* final List? propdetail;
  final List? images;
  final String? tocheck;*/

  const PropDetail({
    super.key,
    /*this.propdetail,
    this.images,
    this.tocheck,*/
  });
  @override
  State<PropDetail> createState() => _PropDetailState();
}

class _PropDetailState extends State<PropDetail> {



  // setUrl(){
  //   html.window.history.pushState(null, '', "/proplisting/list?id=${widget.propdetail![0]['id']}");
  //   // widget.changeViewCallback!();
  // }

  var propdetails;
  List images = [];
  var currImgIndx = 0;

/*  List ammenities = [
    "Smoke Alarms","Dedicated Security personell",
    "Seciruty Camersa","Paved Cabros Roads","First Aid Kits"
  ];*/


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

    return Stack(
        children: [
          propdetails == null ? Text(''): Container(
            color: Colors.white54,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  // margin: EdgeInsets.symmetric(horizontal:5),
                  height: MediaQuery.of(context).size.height * 0.8,
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
                SizedBox(height: 20,),
                SingleChildScrollView(
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
                          width: 150,
                          height: 120,
                        ),
                      );
                    }).toList(),
                  )
                  ,
                ),
                Divider(thickness: 1,color: Colors.black12,),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Text('${propdetails[0]['propName']}',
                                     style: GoogleFonts.kanit(
                                       fontWeight: FontWeight.w500, // Regular weight
                                       fontStyle: FontStyle.normal, // Normal (not italic)
                                       fontSize: 24,
                                     )),
                               ),
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Text('${formatCurrency(int.parse(propdetails[0]['price'] ?? 0))}',
                                     style: GoogleFonts.kanit(
                                       color: Colors.green,
                                       fontWeight: FontWeight.w500, // Regular weight
                                       fontStyle: FontStyle.normal, // Normal (not italic)
                                       fontSize: 24,
                                     )),
                               )
                             ],
                           ),
                            SizedBox(height: 10,),
                            Divider(thickness: 1,color: Colors.black12,),
                            Row(
                              children: [
                                Icon(Icons.pin_drop_outlined),
                                Text('${propdetails[0]['location']}')
                              ],
                            ),
                            SizedBox(height: 10,),
                            Text('${propdetails[0]['description']}',
                              style:TextStyle(
                                letterSpacing: 1,
                                fontSize: 15
                              ) ,),
                            SizedBox(height: 20,),
                            Divider(thickness: 1,color: Colors.black12,),
                           /* SizedBox(height: 20,),
                            Text('Overview',
                                style: GoogleFonts.kanit(
                                  fontWeight: FontWeight.w500, // Regular weight
                                  fontStyle: FontStyle.normal, // Normal (not italic)
                                  fontSize: 24,
                                )
                            ),*/
                            SizedBox(height: 20,),
                            Column(
                              children: [
                               /* Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration:BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(width: 0.1,color: Colors.black)
                                          ),
                                          child: Icon(Icons.home,color: Colors.black87,),
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('ID',style: TextStyle(color: Colors.black87),),
                                            Text('1234',style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration:BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(width: 0.1,color: Colors.black)
                                          ),
                                          child: Icon(Icons.swipe_down_alt_outlined,color: Colors.black87,),
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Type',style: TextStyle(color: Colors.black87),),
                                            Text('House',style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration:BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(width: 0.1,color: Colors.black)
                                          ),
                                          child: Icon(Icons.garage,color: Colors.black87,),
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Garages',style: TextStyle(color: Colors.black87),),
                                            Text('1',style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration:BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(width: 0.1,color: Colors.black)
                                          ),
                                          child: Icon(Icons.bed,color: Colors.black87,),
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Bedrooms',style: TextStyle(color: Colors.black87),),
                                            Text('2',style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),*/
                               /* SizedBox(height:20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration:BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(width: 0.1,color: Colors.black)
                                          ),
                                          child: Icon(Icons.home,color: Colors.black87,),
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('ID',style: TextStyle(color: Colors.black87),),
                                            Text('1234',style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration:BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(width: 0.1,color: Colors.black)
                                          ),
                                          child: Icon(Icons.swipe_down_alt_outlined,color: Colors.black87,),
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Type',style: TextStyle(color: Colors.black87),),
                                            Text('House',style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration:BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(width: 0.1,color: Colors.black)
                                          ),
                                          child: Icon(Icons.garage,color: Colors.black87,),
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Garages',style: TextStyle(color: Colors.black87),),
                                            Text('1',style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration:BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(width: 0.1,color: Colors.black)
                                          ),
                                          child: Icon(Icons.bed,color: Colors.black87,),
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Bedrooms',style: TextStyle(color: Colors.black87),),
                                            Text('2',style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                )*/
                              ],
                            ),
                            SizedBox(height: 20,),

                            (propdetails[0]['videolink'] == null || propdetails[0]['videolink'].isEmpty )  ? SizedBox():Column(
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
                                  width: MediaQuery.of(context).size.width * 0.4,
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
                            SizedBox(height: 20,),
                            Divider(thickness: 1,color: Colors.black12,),
                            SizedBox(height: 20,),
                            (propdetails[0]['ammenities'].isEmpty || propdetails[0]['ammenities'] == null)  ?Text('') :Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Amenities And Features',
                                  style: GoogleFonts.kanit(
                                    fontWeight: FontWeight.w500, // Regular weight
                                    fontStyle: FontStyle.normal, // Normal (not italic)
                                    fontSize: 24,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text('${propdetails[0]['ammenities'] ?? ''}')
                                    ],
                                    /*children: ammenities.map((item){
                                      return Row(
                                        children: [
                                          Icon(Icons.circle,size: 5,),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('${item}'),
                                          ),
                                        ],
                                      );
                                    }).toList()*/
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 100,),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white54
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Seller Information',style: GoogleFonts.kanit(
                              fontWeight: FontWeight.w500, // Regular weight
                              fontStyle: FontStyle.normal, // Normal (not italic)
                              fontSize: 24,
                            )),
                            SizedBox(height: 15,),

                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Fam Limited',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    Row(
                                      children: [
                                        Icon(Icons.call),
                                        SizedBox(width: 10,),
                                        Text("+254-716-544-543")
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    Row(
                                      children: [
                                        Icon(Icons.email),
                                        SizedBox(width: 10,),
                                        Text("sales@famlimited.co.ke")
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 30,),

                            Container(
                              width:300,
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                  child: Text('Contact Seller',
                                    style: TextStyle(color: Colors.white),),
                                ),
                              ),
                            )
                          ],
                        ),


                      ),
                    )
                  ],
                ),

                DektopFooter()
              ],
            ),
          ),
        ],
    );
  }
}
