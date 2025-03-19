import 'dart:convert';

import 'package:famlimited/reusables/reuseconf.dart';
import 'package:famlimited/ytube.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class DispGal extends StatefulWidget {
  final  data;
  const DispGal({super.key,required this.data});

  @override
  State<DispGal> createState() => _DispGalState();
}

class _DispGalState extends State<DispGal> {

  var currImgIndx = 0;


  @override
  Widget build(BuildContext context) {

    List imgs = jsonDecode(widget.data['images']);


    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 0.93,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.navigate_before,size: 30,)
                  ),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${widget.data['propName']}',
                            style: TextStyle(
                              color: Colors.indigo.shade800,
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                            ),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                // margin: EdgeInsets.symmetric(horizontal:5),
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage("${auth.imgurl}/${imgs[currImgIndx]}"),
                    fit: BoxFit.cover, // Adjust the image fit
                  ),
                ),
                child: Center(
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
                          backgroundColor:Colors.black12,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.navigate_before_outlined,size: 60,color: Colors.white,),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){

                          if (currImgIndx < imgs.length - 1) {
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
                          backgroundColor:Colors.black12,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.navigate_next_outlined,size: 60,color: Colors.white,),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgs.asMap().entries.map((entry) {
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
                        height: 100,
                      ),
                    );
                  }).toList(),
                )
                ,
              ),

              (widget.data['videolink'] == null || widget.data['videolink'].isEmpty )  ? Text(''):Column(
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
                        // width: MediaQuery.of(context).size.width * 0.4,
                        decoration:BoxDecoration(
                            color:Colors.blue.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        // child: Text('soke'),
                        // https://www.youtube.com/watch?v=N14jz8ptDx0&pp=ygUKZmFtbGltaXRlZA%3D%3D
                        // child:VideoApp(videoUrl: 'https://www.youtube.com/watch?v=7ESr75F-k3U')
                        child:IframeScreen(url: '${widget.data['videolink']}')
                      // child:YoutubePlayer(videoUrl: '',)
                    ),

                  ]

              ),

              // Text('${widget.data}'),
            ],
          ),
        ),
      ),
    );
  }
}
