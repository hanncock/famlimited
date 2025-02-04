import 'package:famlimited/desktop/admin/addEvent.dart';
import 'package:famlimited/desktop/admin/addgallery.dart';
import 'package:famlimited/desktop/admin/adduser.dart';
import 'package:famlimited/desktop/admin/createProp.dart';
import 'package:famlimited/desktop/admin/homeimages.dart';
import 'package:flutter/material.dart';

class TogleAdmin extends StatefulWidget {
  const TogleAdmin({super.key});

  @override
  State<TogleAdmin> createState() => _TogleAdminState();
}

class _TogleAdminState extends State<TogleAdmin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 280),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateProp() ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 0.1)
                  ),
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                    child: Text('Add property',style: TextStyle(fontSize: 20),)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddUser() ));
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 0.1)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                    child: Text('Add Staff Member',style: TextStyle(fontSize: 20),)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Addgallery() ));
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 0.1)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                    child: Text('Gallery Photos',style: TextStyle(fontSize: 20),)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddEvent() ));
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 0.1)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                    child: Text('Add Event',style: TextStyle(fontSize: 20),)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeImages() ));
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 0.1)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                    child: Text('Home Images',style: TextStyle(fontSize: 20),)),
              ),
            ),

          ],
      ),
    );
  }
}
