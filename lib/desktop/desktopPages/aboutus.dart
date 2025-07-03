import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import '../../controller.dart';
import '../../reusables/reuseconf.dart';
import '../../ytube.dart';
import 'footer.dart';
import 'dart:html' as html;
import 'package:percent_indicator/circular_percent_indicator.dart';



class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> with TickerProviderStateMixin{
  late AnimationController _controller;

  late Animation<double> _animation;




/*  List testimonials = [
    {
      "message":"when they talk about ambience, serenity and luxury. They know what they are talking about. Ruiru villas is the dream",
      "client":"Japhet Kimani",
      "clientposition":"Property Investor"
    },
    {
      "message":"My experience with property management services has exceeded expectations. "
          "They efficiently manage properties with a professional and attentive approach in every situation. I feel reassured that any issue will be resolved promptly and effectively.",
      "client":"Virginia Mugure",
      "clientposition":"Client"
    },
    {
      "message":"FamLimited made selling my home easy and stress free. They went above and beyond what is expected",
      "client":"Catherine Kihara",
      "clientposition":"Home Owner"
    }

  ];*/

  List staffs = [];

  getStaff()async{
    var resu = await auth.getvalues("user/staff/list");
    setState(() {
      staffs = resu;
    });
  }

  @override
  void initState() {
    super.initState();
    getStaff();
    // Create an AnimationController
    _controller = AnimationController(
      duration: Duration(seconds: 5), // Duration of the animation
      vsync: this,
    );

    // Define the animation (move from left to right)
    _animation = Tween<double>(
      begin: 0, // Start at the left
      end: 1, // End at the right
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear, // The animation will move linearly from left to right
    ));

    // Start the animation in a loop
    _controller.repeat(); // Repeats the animation indefinitely
  }



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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

    /*AnimatedBuilder(
    animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            MediaQuery.of(context).size.width * _animation.value, // Move based on animation
            0, // No vertical movement
          ),
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg4.jpg'), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    ),*/


        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height* 0.4,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black12,
                image: DecorationImage(
                  image: AssetImage("assets/images/whysus.webp"), // Specify the image asset
                  fit: BoxFit.cover,  // Adjust the image fit
                ),
              ),
              child: Container(
                color: Colors.black12,
                child: Center(
                  child: Text('Explore new Investment opportunities with FAM LIMITED',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.02,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                    softWrap: true,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /*SizedBox(
                      height: 100,
                      width: 100,
                    ),*/
                    SizedBox(width: 100,),
                    Container(
                        height:500,
                        width: MediaQuery.of(context).size.width * 0.5,
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
                  ],
                ),
                Card(
                  child: Column(
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
                        width: MediaQuery.of(context).size.width * 0.3,
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
                      SizedBox(height: 30,),
                      Container(
                        width: 200,
                        height: 160,
                        child: Image.asset("assets/images/signature.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height: 30,),

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
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height:30),
            Container(
              color:Colors.indigo.shade800.withOpacity(0.1),
              padding:EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 500,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/aboutus.gif"), // Specify the image asset
                        fit: BoxFit.cover,  // Adjust the image fit
                      ),
                    ),
                  ),
                  SizedBox(width: 50,),
                  Column(
                    children: [
                      Text('WHY CHOOSE US',style: GoogleFonts.poppins(
                          height: 1.5,
                          fontSize: 30,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold
                      )),
                      SizedBox(height: 30,),
                      Container(
                        child: DefaultTabController(
                            length: 3,
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  child: TabBar(
                                      tabs:[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('EXPERIENCE'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('SKILL'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('OUR MISSION'),
                                        ),
                                      ]
                                  ),
                                ),
                                Container(
                                  height: 250,
                                  width: MediaQuery.of(context).size.width * 0.4,

                                  child: TabBarView(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text('We pride ourslevs in providing the best real estate investment solutions. '
                                                  'Providing accurate and realsitic solutions to home owners and potential investors.',
                                                softWrap: true,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('Property Advisory'),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: 10, // Height of the line
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.withOpacity(0.3), // Background color of the line
                                                    borderRadius: BorderRadius.circular(4),
                                                  ),
                                                  child: FractionallySizedBox(
                                                    alignment: Alignment.centerLeft,
                                                    widthFactor: 0.79, // This controls the filled part of the line
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.green, // Color of the progress
                                                        borderRadius: BorderRadius.circular(4),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('Site Evaluation'),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: 10, // Height of the line
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.withOpacity(0.3), // Background color of the line
                                                    borderRadius: BorderRadius.circular(4),
                                                  ),
                                                  child: FractionallySizedBox(
                                                    alignment: Alignment.centerLeft,
                                                    widthFactor: 0.72, // This controls the filled part of the line
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.orange, // Color of the progress
                                                        borderRadius: BorderRadius.circular(4),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('Market Evaluation'),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: 10, // Height of the line
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.withOpacity(0.3), // Background color of the line
                                                    borderRadius: BorderRadius.circular(4),
                                                  ),
                                                  child: FractionallySizedBox(
                                                    alignment: Alignment.centerLeft,
                                                    widthFactor: 0.88, // This controls the filled part of the line
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.indigo.shade800, // Color of the progress
                                                        borderRadius: BorderRadius.circular(4),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [

                                              Column(
                                                children: [
                                                  CircularPercentIndicator(
                                                    radius: 60.0,
                                                    lineWidth: 8.0,
                                                    percent: 0.87,  // 75% progress
                                                    center: Text(
                                                      "87%",
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                                                    ),
                                                    progressColor: Colors.blue, // Color of the progress outline
                                                    backgroundColor: Colors.grey.withOpacity(0.3), // Background circle color
                                                  ),
                                                  Text('MARKET ANALYSIS')
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  CircularPercentIndicator(
                                                    radius: 60.0,
                                                    lineWidth: 8.0,
                                                    percent: 0.74,  // 75% progress
                                                    center: Text(
                                                      "74%",
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                                                    ),
                                                    progressColor: Colors.blue, // Color of the progress outline
                                                    backgroundColor: Colors.grey.withOpacity(0.3), // Background circle color
                                                  ),
                                                  Text('SITE EVALUATION')
                                                ],
                                              ),

                                              Column(
                                                children: [
                                                  CircularPercentIndicator(
                                                    radius: 60.0,
                                                    lineWidth: 8.0,
                                                    percent: 0.99,  // 75% progress
                                                    center: Text(
                                                      "99%",
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                                                    ),
                                                    progressColor: Colors.blue, // Color of the progress outline
                                                    backgroundColor: Colors.grey.withOpacity(0.3), // Background circle color
                                                  ),
                                                  Text('PROPERTY ADVISORY')
                                                ],
                                              ),

                                            ],
                                          ),
                                        ],
                                      ),

                                      Center(child: Text('Our mission is to provide the ultimate Real investments solutions '
                                          'while becoming a one-stop shop for every real estate investor available in the industry'))

                                    ],
                                  ),
                                ),


                              ],
                            )
                        ),
                      )

                    ],
                  )
                ],
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.12,),
            Text('Our Team',
              style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 16,letterSpacing: 2),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Meet Our Agents',
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,letterSpacing: 2),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: GridView.builder(
                primary:false,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Two items per row
                  crossAxisSpacing: 10, // Space between items horizontally
                  mainAxisSpacing: 10, // Space between items vertically
                ),
                itemCount: staffs.length,
                itemBuilder: (BuildContext context, int index) {
                  staffs.sort((a, b) => a['id'].compareTo(b['id']));
                  var img = jsonDecode(staffs[index]['images']);
                  var val = staffs[index];
                  return Container(
                    child: Column(
                      children: [
                       /* Container(
                          width: MediaQuery.of(context).size.width * 0.13,
                          height: 230,
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
                              Text('${staffs[index]['mail']}')
                            ],
                          ),
                        ),*/
                        CircleAvatar(
                          radius: 55, // Adjust the size of the avatar
                          backgroundImage:img.isEmpty ? NetworkImage("http://example.com/default_image.png")  :
                          NetworkImage("${auth.imgurl
                          }/${img[0]}"),
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
                              // child: Text('${val['phone']} | ${val['mail']}'),
                              child: Text('${val['phone']}'),
                            ),
                            Text('${val['designation']}',style: TextStyle(color: Colors.indigo.shade800),),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            /*Container(
              // color: Colors.lightBlue.withOpacity(0.01),
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                  Text('Testimonials',
                    style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 16,letterSpacing: 2),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('What Our Clients Say',
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,letterSpacing: 2),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:List.generate(testimonials.length, (index) => Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        width: 400,
                        height: 400,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1,color: Colors.black12)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Icon(Icons.format_quote_rounded,size: 16,color: Colors.blueAccent,),
                              ],
                            ),
                            Text('${testimonials[index]['message']}',softWrap: true,
                            textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 16
                              ),
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  child: Icon(Icons.person),
                                ),
                                SizedBox(width: 20,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${testimonials[index]['client']}'),
                                    Text('${testimonials[index]['clientposition']}'),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ))
                  )
                ],
              ),
            ),*/

            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            DektopFooter()
          ],
        ),
      ],
    );
  }
}
