// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'dart:html' as html;
//
// import '../../reusables/reuseconf.dart';
//
//
// class Addgallery extends StatefulWidget {
//   const Addgallery({super.key});
//
//   @override
//   State<Addgallery> createState() => _AddgalleryState();
// }
//
// class _AddgalleryState extends State<Addgallery> {
//
//
//   var id;
//   List base64Image = [];
//   List imguploads = [];
//   var returned;
//
//   List gallery_images = [];
//
//
//   getImages()async{
//     var resu = await auth.getvalues("property/gallery/list");
//     setState(() {
//       gallery_images = resu;
//     });
//     print(gallery_images);
//   }
//
//
//   void pickImage() async {
//     html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
//     uploadInput.accept = 'image/*'; // Accept only image files
//     uploadInput.click();
//
//     // Wait for the file to be selected
//     uploadInput.onChange.listen((e) async {
//       final files = uploadInput.files;
//       if (files!.isEmpty) return;
//
//       final file = files[0]!; // Get the selected file
//       final reader = html.FileReader();
//       reader.readAsDataUrl(file); // Read the file as a data URL (Base64)
//
//       reader.onLoadEnd.listen((e) {
//         final base64String = reader.result as String;
//         final mimeType = file.type;  // Extract the MIME type from the file
//
//         // Ensure we are adding only the base64 encoded part of the Data URL
//         final base64EncodedImage = base64String.split(',').last;
//
//         // Construct the full Data URL with MIME type and Base64 encoding
//         final mimeTypeBase64String = 'data:$mimeType;base64,$base64EncodedImage';
//
//         setState(() {
//           base64Image.add(mimeTypeBase64String); // Store the full Data URL with MIME type
//           if(id==null){
//             imguploads.add(mimeTypeBase64String);
//           }else{}  // Add the full Data URL with MIME type
//         });
//       });
//     });
//   }
//
//   @override
//   void initState(){
//     super.initState();
//     getImages();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Row(
//             children: [
//               Row(
//                 children: [
//                   base64Image.isNotEmpty
//                       ? Row(
//                     children: base64Image.map((e) => Container(
//                       margin: EdgeInsets.all(2),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         image: DecorationImage(
//                           image: e.length>30 ? NetworkImage(e):NetworkImage("${auth.imgurl}/${e}"),
//                           // image: NetworkImage(e),//NetworkImage("${auth.imgurl}/${e}"),
//                           fit: BoxFit.cover, // Adjust the image fit
//                         ),
//                       ),
//                       child: InkWell(
//                           onTap: (){
//                             print(e['id']);
//                             print(e);
//
//                             // var resu = await auth.delete(e['id'],'api/property/proplisting/del');
//                           },
//                           child: Icon(Icons.close,color: Colors.redAccent,)),
//                       width: 150,
//                       height: 100,
//                       // child: Image.network(e),
//                     )).toList(),
//                   ) // Display image using base64 string
//                       : Text('No image selected'),
//                 ],
//               ),
//               InkWell(
//                 onTap: () async {
//                   Map propdata = {
//                     "id": id,
//                     // "propName": _propNameController.text,
//                     // "location": _locationController.text,
//                     // "price": _priceController.text,
//                     // "featured":_selectedValue,
//                     // "description": _descriptionController.text,
//                     // "ammenities":_ammenitiesController.text,
//                     "images":imguploads
//                   };
//                   var resu = await auth.saveMany(propdata,'/api/property/gallery/add');
//                   // var resu = await auth.saveMany(propdata,'/api/property/proplisting/save');
//                   setState(() {
//                     returned = resu;
//                   });
//                   // print(resu);
//                   if(resu == 'success'){
//                     // _propNameController.clear();
//                     // _locationController.clear();
//                     // _priceController.clear();
//                     // _descriptionController.clear();
//                     // _ammenitiesController.clear();
//                     id = null;
//                     base64Image.clear();
//                     imguploads.clear();
//                     setState(() {});
//                   }
//                   getImages();
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.blueAccent,
//                       borderRadius: BorderRadius.circular(5)
//                   ),
//                   child: Padding(
//                     padding:  EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
//                     child: Text('Save', style: TextStyle(color: Colors.white),),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           InkWell(
//             onTap: (){
//               pickImage();
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   border: Border.all(
//                       width: 1
//                   )
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text('Choose Image'),
//               ),
//             ),
//           ),
//           Divider(),
//           Column(
//             children: [
//               Container(
//                 height: 400,
//                 child: ListView.builder(
//
//                     shrinkWrap: true,
//                     itemCount: gallery_images.length,
//                     itemBuilder: (context, index){
//                       var e = gallery_images[index];
//                       List<dynamic> img = e["images"] == null ? [] : jsonDecode(gallery_images[index]['images']); //= e["images"] == null ? null: gallery_images[index]['images'].split(',');
//                       return Column(
//                         children: [
//                           InkWell(
//                             onTap: () {
//
//                               /* _propNameController.clear();
//                           _locationController.clear();
//                           _priceController.clear();
//                           _descriptionController.clear();
//                           _ammenitiesController.clear();
//                           id = null;
//                           base64Image.clear();
//                           imguploads.clear();
//                           setState(() {});*/
//
//                               // id = e['id'];
//                               // _propNameController.text = e['propName'];
//                               // _locationController.text = e['location'];
//                               // _descriptionController.text = e['description'];
//                               // _priceController.text = e['price'];
//                               // _selectedValue = e['featured'];
//                               // _ammenitiesController.text = e['ammenities']??'';
//                               // imguploads = img;
//                               // base64Image = img;
//                               // setState(() {});
//                               // print(e);
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Container(
//                                   height:80,
//                                   width:80,
//                                   decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                       image: img.isEmpty ? NetworkImage("http://example.com/default_image.png")  :
//                                       NetworkImage("${auth.imgurl}/${img[0]}"),
//                                     ),
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                                 InkWell(
//                                     onTap: ()async{
//                                       // print(e['id']);
//                                       //
//                                       var resu = await auth.delete(e['id'],'api/property/proplisting/del',null);
//                                       getImages();
//                                     },
//                                     child: Icon(Icons.delete,color: Colors.red,))
//                               ],
//                             ),
//                           ),
//                           Divider(thickness: 1,),
//                         ],
//                       );
//                     }),
//               )
//             ]
//           )
//         ],
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../reusables/reuseconf.dart';
import '../../reusables/txtform.dart';
import 'dart:html' as html;

class Addgallery extends StatefulWidget {
  const Addgallery({super.key});

  @override
  State<Addgallery> createState() => _AddgalleryState();
}

class _AddgalleryState extends State<Addgallery> {
  final TextEditingController _propNameController = TextEditingController();
  final TextEditingController videolink = TextEditingController(); //https://drive.google.com/file/d/1OlGFd7FKTbSOzENB72lDgXyZzULxjJ-L/view?t=2
  var _selectedValue = 'NO';
  var type  = 'Gallery';


  var id;
  List props = [];
  List base64Image = [];
  List imguploads = [];
  var returned;


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
          if(id==null){
            imguploads.add(mimeTypeBase64String);
          }else{}  // Add the full Data URL with MIME type
        });
      });
    });
  }

  getProp() async {
    var resu = await auth.getvalues("property/proplisting/list");
    setState(() {
      props = resu;
    });
  }


  @override
  void initState() {
    super.initState();
    getProp();
  }

  @override
  void dispose() {
    // Dispose controllers to free resources
    _propNameController.dispose();
    videolink.dispose();
    super.dispose();
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
                        hint: 'Property/Land Name',
                        label: "Property Name",
                        txtcontroller: _propNameController,
                        onChanged: (String value) {
                          setState(() {
                            _propNameController.text = value;
                          });
                        },
                      ),

                      Row(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Coming Soon'),
                              ),
                              DropdownButton<String>(
                                value: _selectedValue,
                                items: <String>['YES', 'NO'].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedValue = newValue.toString();
                                  });
                                },
                              ),
                            ],
                          ),

                          forms(
                            hint: 'Video Link',
                            label: "Video Link",
                            txtcontroller: videolink,
                            onChanged: (String value) {
                              setState(() {
                                videolink.text = value;
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text('${base64Image.length}'),
                      // Text('${imguploads.length}'),

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
                          child: InkWell(
                              onTap: ()async{
                                var resu = await auth.delete(e['id'],'api/property/proplisting/del',"${e}");
                              },
                              child: Icon(Icons.close,color: Colors.redAccent,)),
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
                      InkWell(
                        onTap: () async {
                          Map propdata = {
                            "id": id,
                            "propName": _propNameController.text,
                            "videolink":videolink.text,
                            "type":type,
                            "images":imguploads
                          };
                          var resu = await auth.saveMany(propdata,'/api/property/proplisting/add');
                          // var resu = await auth.saveMany(propdata,'/api/property/proplisting/save');
                          setState(() {
                            returned = resu;
                          });
                          // print(resu);
                          if(resu == 'success'){
                            _propNameController.clear();
                            videolink.clear();
                            id = null;
                            base64Image.clear();
                            imguploads.clear();
                            setState(() {});
                          }
                          getProp();
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

                  /*Text('Listings',style: TextStyle(color: Colors.black),),
          Text('${returned}'),*/
                  Divider(thickness: 0.5, color: Colors.black,),
                  Column(
                    children: [
                      Container(
                        height: 400,
                        child: ListView.builder(

                            shrinkWrap: true,
                            itemCount: props.length,
                            itemBuilder: (context, index){
                              var e = props[index];
                              List<dynamic> img = e["images"] == null ? [] : jsonDecode(props[index]['images']); //= e["images"] == null ? null: props[index]['images'].split(',');
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {

                                      id = e['id'];
                                      _propNameController.text = e['propName'];
                                      videolink.text = e['videolink']??'';
                                      imguploads = img;
                                      base64Image = img;
                                      setState(() {});
                                      print(e);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(width: 150, child: Text('${e['propName']}')),

                                        Container(
                                          height:80,
                                          width:80,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: img.isEmpty ? NetworkImage("http://example.com/default_image.png")  :
                                              NetworkImage("${auth.imgurl}/${img[0]}"),
                                            ),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        InkWell(
                                            onTap: ()async{
                                              print(e['id']);

                                              var resu = await auth.delete(e['id'],'api/property/proplisting/del',null);
                                              print(resu);
                                              getProp();
                                            },
                                            child: Icon(Icons.delete,color: Colors.red,))
                                      ],
                                    ),
                                  ),
                                  Divider(thickness: 1,),
                                ],
                              );
                            }),
                      )
                    ],

                  )
                ],
              )
            ]
        )
    );
  }
}
