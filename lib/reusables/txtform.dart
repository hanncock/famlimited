import 'package:flutter/material.dart';


class forms extends StatefulWidget {

  final String? label;
  final TextEditingController? txtcontroller;
  final ValueChanged<String> onChanged;
  final Icon? icon;
  // final value;
  double? widthh;
  double? heighht;
  String? hint;
  final int? linecnt;
  forms({
    Key? key,
    // required this.value,
    this.txtcontroller,
    this.label,
    this.widthh,
    this.hint,
    required this.onChanged,
    this.linecnt,
    this.icon
  }) : super(key: key);

  @override
  State<forms> createState() => _formsState();
}

class _formsState extends State<forms> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // widget.label == null? SizedBox(): Text('${widget.label}',style: boldfont,),
          Container(
            width: widget.widthh ?? 300 ,
            height: (widget.linecnt == null ?35 : null),//: widget.width,
            decoration: BoxDecoration(
                border: Border.all(width: 1,color: Colors.black45),
                borderRadius: BorderRadius.circular(6),
                color: Colors.white
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 4,bottom: 10),
                child: TextFormField(
                  controller: widget.txtcontroller,
                  maxLines: widget.linecnt,
                  // textAlign: TextAlign.justify,
                  onChanged: widget.onChanged,
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 5,top: 2,bottom: 5),
                    icon: widget.icon,

                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelStyle: TextStyle(fontFamily: "Muli"),

                    hintText: '${widget.hint}',
                    // hintStyle: boldfont
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class ContainerWithFourImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // First image (top-left)
        Positioned(
          top: 0,
          left: 0,
          child: Image.asset(
            'assets/images/outreach3.webp', // Replace with your image path
            height: MediaQuery.of(context).size.height * 0.5 /2,
            width: MediaQuery.of(context).size.width * 0.4 /2,
            fit: BoxFit.cover,
          ),
        ),
        // Second image (top-right)
        Positioned(
          top: 0,
          right: 0,
          child: Image.asset(
            'assets/images/outreach1.webp', // Replace with your image path
            height: MediaQuery.of(context).size.height * 0.5 /2,
            width: MediaQuery.of(context).size.width * 0.4 /2,
            fit: BoxFit.cover,
          ),
        ),
        // Third image (bottom-left)
        Positioned(
          bottom: 0,
          left: 0,
          child: Image.asset(
            'assets/images/outreach2.webp', // Replace with your image path
            height: MediaQuery.of(context).size.height * 0.5 /2,
            width: MediaQuery.of(context).size.width * 0.4 /2,
            fit: BoxFit.cover,
          ),
        ),
        // Fourth image (bottom-right)
        Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset(
            'assets/images/farmoutreach.webp', // Replace with your image path
            height: MediaQuery.of(context).size.height * 0.5 /2,
            width: MediaQuery.of(context).size.width * 0.4 /2,
            fit: BoxFit.cover,
          ),
        ),
        // Optionally, add a semi-transparent color overlay to make the images blend better
        Container(
          height: MediaQuery.of(context).size.height * 0.5 /2,
          width: MediaQuery.of(context).size.width * 0.4 /2,
          color: Colors.black.withOpacity(0.2), // Adjust opacity as needed
        ),
      ],
    );
  }
}