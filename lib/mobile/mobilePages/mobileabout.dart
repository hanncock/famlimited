import 'dart:convert';

import 'package:famlimited/desktop/desktopPages/footer.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import '../../controller.dart';
import '../../reusables/reuseconf.dart';
import '../../ytube.dart';

class MobileAbout extends StatefulWidget {
  const MobileAbout({super.key});

  @override
  State<MobileAbout> createState() => _MobileAboutState();
}

class _MobileAboutState extends State<MobileAbout> {

  List staffs = [];

  getStaff()async{
    var resu = await auth.getvalues("user/staff/list");
    setState(() {
      staffs = resu;
    });
  }

  @override
  void initState(){
    super.initState();
    getStaff();
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
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height* 0.4,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg4.webp"), // Specify the image asset
                    fit: BoxFit.cover,  // Adjust the image fit
                  ),
                ),
                child: Container(
                  color: Colors.black12,
                  child: Center(
                    child: Text('Explore new Investment opportunities with FAM LIMITED',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                      softWrap: true,
                    ),
                  ),
                ),
              ),
              Container(
                  height:300,
                  width: MediaQuery.of(context).size.width ,
                  decoration:BoxDecoration(
                      color:Colors.blue.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  // child: Text('soke'),
                  // https://www.youtube.com/watch?v=N14jz8ptDx0&pp=ygUKZmFtbGltaXRlZA%3D%3D
                  // child:VideoApp(videoUrl: 'https://www.youtube.com/watch?v=7ESr75F-k3U')
                  child:Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: IframeScreen(url: 'https://drive.google.com/file/d/1FQmFbJrxKzq4KJwLm1IhGIfk4bYQgLzV/view?t=10'),
                  )
                // child:YoutubePlayer(videoUrl: '',)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Welcome to FAM Limited',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.black
                        ),),
                      SizedBox(height: 20,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Welcome to FAM Limited, where we turn houses into homes and dreams into reality. A"
                                "t Home, we understand that a home is more than just a physical space, "
                                "it's a place where memories are created, families grow, and life unfolds.",
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                              letterSpacing: 2,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Column(
                        children: [
                          Text('George A. Fundi ',
                            style: TextStyle(
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16
                            ),
                          ),
                          Text('CEO & Founder'),
                        ],
                      ),
                      Container(
                        width: 160,
                        height: 80,
                        child: Image.asset("assets/images/signature.webp",
                          fit: BoxFit.fill,
                        ),
                      )
                    ],
                  ),

                ],
              ),
              Container(

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.indigo.shade800
                ),
                width: 350,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Contact Us',style: TextStyle(color: Colors.white),),
                      SizedBox(width: 20,),
                      Icon(Icons.near_me_rounded,color: Colors.white,)
                    ],
                  ),
                ),
              ),
              Text('Our Team',
                style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 16,letterSpacing: 2),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Meet Our Agents',
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,letterSpacing: 2),
                ),
              ),
              GridView.builder(
                primary: false,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two items per row
                  crossAxisSpacing: 10, // Space between items horizontally
                  mainAxisSpacing: 10, // Space between items vertically
                ),
                itemCount: staffs.length,
                itemBuilder: (BuildContext context, int index) {
                  staffs.sort((a, b) => a['id'].compareTo(b['id']));
                  var val = staffs[index];
                  var img = jsonDecode(staffs[index]['images']);
                  return Container(
                    child: Column(
                      children: [
                        /*Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                            image: DecorationImage(
                              scale: 1.0,
                              image: NetworkImage("http://192.168.1.129:3000/property/propImages/${img[0]}"),
                              // image: AssetImage('assets/images/bg4.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Social Links')
                            ],
                          ),
                        ),*/
                        CircleAvatar(
                          radius: 60, // Adjust the size of the avatar
                          backgroundImage:img.isEmpty ? NetworkImage("http://example.com/default_image.png")  :
                          NetworkImage("${auth.imgurl}/${img[0]}"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('${val['staffName']}',
                              style: TextStyle(
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 16
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${val['phone']}',
                              softWrap: true,
                              ),
                            ),
                            Text('${val['designation']}',style: TextStyle(fontWeight: FontWeight.w800),),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 20,),
              DektopFooter(mobile: "true",)
            ],
          ),
        ),
      ),
    );
  }
}
