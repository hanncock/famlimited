import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:html' as html;
import '../../reusables/reuseconf.dart';
import '../../reusables/txtform.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {

  final TextEditingController staffName = TextEditingController();
  final TextEditingController staffcontacr = TextEditingController();
  final TextEditingController staffmail = TextEditingController();
  final TextEditingController position = TextEditingController();
  var _selectedValue = 'NO';


  var id;
  List staffs = [];
  List base64Image = [];
  List imguploads = [];
  var returned;

  getUsers() async {
    var resu = await auth.getvalues("user/staff/list");
    setState(() {
      staffs = resu;
    });
  }


  void pickImage() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*'; // Accept only image files
    uploadInput.click();

    // Wait for the file to be selected
    uploadInput.onChange.listen((e) async {
      final files = uploadInput.files;
      if (files!.isEmpty) return;

      final file = files[0]!; // Get the selected file
      final reader = html.FileReader();
      reader.readAsDataUrl(file); // Read the file as a data URL (Base64)

      reader.onLoadEnd.listen((e) {
        final base64String = reader.result as String;
        final mimeType = file.type;  // Extract the MIME type from the file

        // Ensure we are adding only the base64 encoded part of the Data URL
        final base64EncodedImage = base64String.split(',').last;

        // Construct the full Data URL with MIME type and Base64 encoding
        final mimeTypeBase64String = 'data:$mimeType;base64,$base64EncodedImage';

        setState(() {
          base64Image.add(mimeTypeBase64String); // Store the full Data URL with MIME type
          imguploads.add(mimeTypeBase64String);  // Add the full Data URL with MIME type
        });
      });
    });
  }

  void initState(){
    super.initState();
    getUsers();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100,),
          Column(
            children: [
              Row(
                children: [
                  forms(
                    hint: 'Name',
                    label: "Name",
                    txtcontroller: staffName,
                    onChanged: (String value) {
                      setState(() {
                        staffName.text = value;
                      });
                    },
                  ),
                  forms(
                    hint: 'Email',
                    label: "Email",
                    txtcontroller: staffmail,
                    onChanged: (String value) {
                      setState(() {
                        staffmail.text = value;
                      });
                    },
                  ),
                  forms(
                    hint: 'Phone',
                    label: "Phone",
                    txtcontroller: staffcontacr,
                    onChanged: (String value) {
                      setState(() {
                        staffcontacr.text = value;
                      });
                    },
                  ),
                  forms(
                    hint: 'Position',
                    label: "Role / Position",
                    txtcontroller: position,
                    onChanged: (String value) {
                      setState(() {
                        position.text = value;
                      });
                    },
                  ),
      
                  InkWell(
                    onTap: () async {
      
                    /*  private string $staffName;
                      private string $designation;
                      private string $phone;
                      private string $mail;
                      private string $images;*/
      
                      Map propdata = {
                        "id": id,
                        "staffName": staffName.text,
                        "designation": position.text,
                        "phone": staffcontacr.text,
                        "mail":staffmail.text,
                        "images":imguploads
                      };
                      var resu = await auth.saveMany(propdata,'/api/user/staff/add');
                      // var resu = await auth.saveMany(propdata,'/api/property/proplisting/save');
                      setState(() {
                        returned = resu;
                      });
                      // print(resu);
                      if(resu == 'success'){
                        staffName.clear();
                        staffmail.clear();
                        staffcontacr.clear();
                        position.clear();
                        id = null;
                        base64Image.clear();
                        imguploads.clear();
                        setState(() {});
                      }
                      getUsers();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                        child: Text('Save', style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),
      
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
      
                    base64Image.isNotEmpty
                        ? Row(
                      children: base64Image.map((e) => Container(
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: e.length>30 ? NetworkImage(e):NetworkImage("${auth.imgurl}/${e}"),
                            // image: NetworkImage(e),//NetworkImage("${auth.imgurl}/${e}"),
                            fit: BoxFit.cover, // Adjust the image fit
                          ),
                        ),
                        child: Text('${e.length}'),
                        width: 150,
                        height: 100,
                        // child: Image.network(e),
                      )).toList(),
                    ) // Display image using base64 string
                        : Text('No image selected'),
      
                    InkWell(
                      onTap: (){
                        pickImage();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: 1
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Choose Image'),
                        ),
                      ),
                    ),
                    // Image.file(_imageFile as File),
                  ],
                ),
              ),
              Divider()
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Photo'),
                  VerticalDivider(),
                  Text('Name'),
                  VerticalDivider(),
                  Text('Phone'),
                  VerticalDivider(),
                  Text('Designation /Position'),
                  VerticalDivider(),
                  Text('')
                ],
              ),
            ),
          ),
          Divider(),
          Container(
            child: Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: staffs.length,
                    itemBuilder: (context, index){
                      staffs.sort((a, b) => a['id'].compareTo(b['id']));
                      var vals = staffs[index];
                      var img = jsonDecode(staffs[index]['images']);
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              id = vals['id'];
                              staffName.text = vals['staffName'];
                              position.text = vals['designation'];
                              staffcontacr.text = vals['phone'];
                              staffmail.text = vals['mail'];

                              imguploads = img;
                              base64Image = img;
                              setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 100.0),
                              child: Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                children: [

                                  CircleAvatar(
                                    radius: 40, // Adjust the size of the avatar
                                    backgroundImage:img.isEmpty ? NetworkImage("http://example.com/default_image.png")  :
                                    NetworkImage("${auth.imgurl}/${img[0]}"),
                                  ),

                                  Text('${vals['staffName']}'),
                                  Text('${vals['phone']}'),
                                  Text('${vals['mail']}'),
                                  Text('${vals['designation']}'),
                                  InkWell(
                                      onTap: ()async{
                                        print(vals['id']);

                                        var resu = await auth.delete(vals['id'],'api/user/staff/del',null);
                                        print(resu);
                                        getUsers();
                                      },
                                      child: Icon(Icons.delete,color: Colors.red,))
                                ],
                              ),
                            ),
                          ),
                          Divider()
                        ],
                      );
                    }
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
