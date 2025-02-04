import 'package:famlimited/reusables/socialmedia.dart';
import 'package:flutter/material.dart';

import '../../reusables/reuseconf.dart';

class DektopFooter extends StatelessWidget {
  String? mobile;
   DektopFooter({super.key, this.mobile});

  TextStyle footertext = TextStyle(
    color: Colors.white
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF140354),
      // height: 200,
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 100,
                  height: 80,
                  child: Image.asset("assets/images/logo.jpg"),
                ),
              ),
              SocialMedia()
            ],
          ),
          Divider(thickness: 0.5,color: Colors.white60,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.call,color: Colors.white,),
                      SizedBox(width: 20,),
                      Text('+254 716 544 543',style: footertext,)
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Icon(Icons.email,color: Colors.white,),
                      SizedBox(width: 20,),
                      Text('sales@famlimited.co.ke',style: footertext,)
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Icon(Icons.location_history,color: Colors.white,),
                      SizedBox(width: 20,),
                      Text('Spur Mall 2nd floor suite 006.',style: footertext,)
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.circle,color: Colors.white,size:5),
                      SizedBox(width: 20,),
                      Text('About Us',style: footertext,)
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Icon(Icons.circle,color: Colors.white,size:5),
                      SizedBox(width: 20,),
                      Text('Now Selling',style: footertext,)
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Icon(Icons.circle,color: Colors.white,size:5),
                      SizedBox(width: 20,),
                      Text('Our Team',style: footertext,)
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Icon(Icons.circle,color: Colors.white,size:5),
                      SizedBox(width: 20,),
                      Text('Gallery',style: footertext,)
                    ],
                  )
                ],
              ),
             mobile == "true"? SizedBox():InkWell(
               onTap: (){
                 launchwhtsapp("Hello, i Would like to view some of your property sites");
               },
               child: Container(
                  height:50,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blueAccent
                  ),
                  child: Center(child: Text('Book a site visit',style: TextStyle(color: Colors.white,fontSize: 14),)),
                ),
             )
            ],
          ),
          Divider(thickness: 0.5,color: Colors.white60,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.copyright,color: Colors.white,),
                Text('${DateTime.now().year}',style: footertext,),
                SizedBox(width: 10,),
                Text('FAM LIMITED All Rights Reserved',style: footertext,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
