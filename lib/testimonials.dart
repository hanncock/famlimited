import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:html' as html;
import 'controller.dart';
import 'desktop/desktopPages/footer.dart';

class Testimonials extends StatefulWidget {
  final String? mbl;
  const Testimonials({super.key, this.mbl});

  @override
  State<Testimonials> createState() => _TestimonialsState();
}

class _TestimonialsState extends State<Testimonials> {

  List testimonials = [
    {
      "message":"when they talk about ambience, serenity and luxury. They know what they are talking about. Ruiru villas is the dream",
      "client":"Japhet Kimani",
      "clientposition":"Property Investor",
      "location":"Texas - USA"
    },
    {
      "message":"My experience with property management services has exceeded expectations. "
          "They efficiently manage properties with a professional and attentive approach in every situation. I feel reassured that any issue will be resolved promptly and effectively.",
      "client":"Virginia Mugure",
      "clientposition":"Client",
      "location":"Nairobi"
    },
    {
      "message":"FamLimited made selling my home easy and stress free. They went above and beyond what is expected",
      "client":"Catherine Kihara",
      "clientposition":"Home Owner",
      "location":"New Jersey"
    },

    {
      "message": "The level of professionalism at Ruiru Villas is unmatched. The attention to detail and commitment to quality truly makes it a luxurious experience.",
      "client": "David Otieno",
      "clientposition": "Real Estate Developer",
      "location": "Nairobi"
    },
    {
      "message": "Purchasing my home with FamLimited was a seamless process. The team was supportive and guided me through every step with ease. Highly recommend!",
      "client": "Olivia Wambui",
      "clientposition": "First-time Homebuyer",
      "location": "London"
    },
    {
      "message": "I’m impressed with how quickly and effectively the property management team handled everything. It’s clear they have a great deal of experience.",
      "client": "Samuel Mwangi",
      "clientposition": "Investor",
      "location": "Dallas"
    },
    {
      "message": "From the first consultation to the final sale, I felt cared for. FamLimited made every step of the journey easy and transparent.",
      "client": "Monica Njeri",
      "clientposition": "Home Seller",
      "location": "Los Angeles"
    },
    {
      "message": "Every time I visit Ruiru Villas, I’m reminded of why I invested. The peace and luxury here are unlike anything else.",
      "client": "Tom Muriuki",
      "clientposition": "Luxury Property Owner",
      "location": "Berlin"
    },
    {
      "message": "I am beyond satisfied with the property management services provided. The team is proactive and always finds the best solutions for my properties.",
      "client": "Caroline Wanjiru",
      "clientposition": "Landlord",
      "location": "New York"
    },
    {
      "message": "Working with FamLimited was a breeze! Their dedication to customer satisfaction and excellent service made selling my home so much easier.",
      "client": "Peter Mbugua",
      "clientposition": "Home Seller",
      "location": "Chicago"
    },
    {
      "message": "Ruiru Villas lives up to its reputation. It's the perfect blend of serenity and modern luxury, offering the ideal lifestyle.",
      "client": "Grace Achieng",
      "clientposition": "Luxury Real Estate Investor",
      "location": "Miami"
    },
    {
      "message": "I couldn't be happier with my investment. The entire team at FamLimited made my buying experience smooth and stress-free.",
      "client": "James Kamau",
      "clientposition": "Real Estate Investor",
      "location": "Houston"
    },
    {
      "message": "Excellent service and a great property management team. I always feel confident that my property is in good hands with them.",
      "client": "Naomi Kariuki",
      "clientposition": "Property Owner",
      "location": "Dubai"
    }

  ];

  @override
  Widget build(BuildContext context) {

    html.window.onPopState.listen((event) {
      TapController().getView();
      // Prevent browser back button behavior
      html.window.history.pushState(TapController().getView(), '', html.window.location.href);
    });

    return Container(
      height: MediaQuery.of(context).size.height * 0.92,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            widget.mbl == "desktop" ? Container(
              height: 300,
              margin: EdgeInsets.symmetric(horizontal: 0),
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage("assets/images/bg4.jpg"), // Specify the image asset
                  fit: BoxFit.cover,  // Adjust the image fit
                ),
              ),
              child: Center(child: Text('Contact Us',style: TextStyle(color: Colors.white,fontSize: 20),)),
            ):
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
              width: widget.mbl == "desktop" ? MediaQuery
                  .of(context)
                  .size
                  .width * 0.6 : MediaQuery
                  .of(context)
                  .size
                  .width,
              child: GridView.builder(
                shrinkWrap: true,
                  primary: false,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:  widget.mbl == "desktop"? 2:  1 , // Two items per row
                    crossAxisSpacing: 10, // Space between items horizontally
                    mainAxisSpacing: 10,
                    childAspectRatio: widget.mbl == "desktop"? MediaQuery.of(context).size.width /2/400 :MediaQuery.of(context).size.width /2/150 , // You can modify this to change the ratio
                    // Space between items vertically
                  ),
                  itemCount: testimonials.length,
                  itemBuilder: (context, index){
                    var e = testimonials[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // width: widget.mbl == "desktop" ? 500 : 350,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            border:Border.all(width: 1,color: Colors.black12)
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                          backgroundColor:Colors.indigo,
                                          child: Icon(Icons.person_3_outlined,color: Colors.white70,)),
                                      VerticalDivider(thickness: 0.5,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${e['client']}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800),),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('${e['location']}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${e['message']}',softWrap: true,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.star,color: Colors.yellow,),
                                      Icon(Icons.star,color: Colors.yellow,),
                                      Icon(Icons.star,color: Colors.yellow,),
                                      Icon(Icons.star,color: Colors.yellow,),
                                      Icon(Icons.star,),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            /*Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: testimonials.map((e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: widget.mbl == "desktop" ? 500 : 350,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    border:Border.all(width: 1,color: Colors.black12)
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                CircleAvatar(
                                    backgroundColor:Colors.indigo,
                                    child: Icon(Icons.person_3_outlined,color: Colors.white70,)),
                                VerticalDivider(thickness: 0.5,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${e['client']}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800),),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('${e['location']}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${e['message']}',softWrap: true,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.star,color: Colors.yellow,),
                                Icon(Icons.star,color: Colors.yellow,),
                                Icon(Icons.star,color: Colors.yellow,),
                                Icon(Icons.star,color: Colors.yellow,),
                                Icon(Icons.star,),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )).toList(),

            ),*/
            widget.mbl == "desktop" ? DektopFooter() : DektopFooter(mobile: "true",),

          ],
        ),

      ),
    );
  }
}
