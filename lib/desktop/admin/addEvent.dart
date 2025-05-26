// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'dart:html' as html;
//
// import '../../reusables/reuseconf.dart';
//
//
// class AddEvent extends StatefulWidget {
//   const AddEvent({super.key});
//
//   @override
//   State<AddEvent> createState() => _AddEventState();
// }
//
// class _AddEventState extends State<AddEvent> {
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
import '../../reusables/shimmer.dart';
import '../../reusables/txtform.dart';
import 'dart:html' as html;
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final TextEditingController _propNameController = TextEditingController();
  final TextEditingController videolink = TextEditingController(); //https://drive.google.com/file/d/1OlGFd7FKTbSOzENB72lDgXyZzULxjJ-L/view?t=2
  var _selectedValue = 'NO';
  var type  = 'Event';


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
    var resu = await auth.getvalues("property/proplisting/list?type=Event");
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
      appBar: AppBar(
        title: Text('Add New Event'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Event Details', style: Theme.of(context).textTheme.titleLarge),
                        SizedBox(height: 16),
                        forms(
                          hint: 'Event Title',
                          label: "Event Name",
                          txtcontroller: _propNameController,
                          onChanged: (String value) {
                            setState(() {
                              _propNameController.text = value;
                            });
                          },
                        ),
                        SizedBox(height: 12),
                        forms(
                          hint: 'Video Link',
                          label: "Drive Video Link",
                          txtcontroller: videolink,
                          onChanged: (String value) {
                            setState(() {
                              videolink.text = value;
                            });
                          },
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Text('Coming Soon:', style: TextStyle(fontWeight: FontWeight.w600)),
                            SizedBox(width: 10),
                            DropdownButton<String>(
                              value: _selectedValue,
                              items: ['YES', 'NO'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  _selectedValue = val!;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text('Images', style: TextStyle(fontWeight: FontWeight.w600)),
                        SizedBox(height: 10),
                      ],
                    ),
                    base64Image.isNotEmpty
                        ? Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: base64Image.map((e) => Container(
                            margin: EdgeInsets.all(2),
                            width: 150,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: e.length > 30 ? e : "${auth.imgurl}/$e",
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        color: Colors.white,
                                      ),
                                    ),
                                    // errorWidget: (context, url, error) => Icon(Icons.error),
                                    errorWidget: (context, url, error) => RetryableImage(imagePath: "${auth.imgurl}/$e", baseUrl: "${auth.imgurl}/$e"),
                                  ),
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: InkWell(
                                      onTap: () async {
                                        var resu = await auth.delete(e['id'], 'api/property/proplisting/del', "$e");
                                      },
                                      child: Icon(Icons.close, color: Colors.redAccent),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )).toList(),
                        ),
                      ),
                    )
                        : Text('No image selected.'),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: pickImage,
                          icon: Icon(Icons.image),
                          label: Text('Choose Image'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[700]),
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () async {
                            Map<String, dynamic> propdata = {
                              "id": id,
                              "propName": _propNameController.text,
                              "videolink": videolink.text,
                              "featured": _selectedValue,
                              "type": type,
                              "images": imguploads,
                            };

                            print(propdata);

                            var resu = await auth.saveMany(propdata, '/api/property/proplisting/add');
                            if (resu == 'success') {
                              _propNameController.clear();
                              videolink.clear();
                              base64Image.clear();
                              imguploads.clear();
                              id = null;
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Event saved successfully.")));
                              getProp();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                          child: Text('Save Event'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            Text('Event Listings', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 10),
            props.isNotEmpty
                ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: props.length,
              itemBuilder: (context, index) {
                var e = props[index];
                List<dynamic> img = e["images"] == null ? [] : jsonDecode(e["images"]);

                return Card(
                  elevation: 1,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: img.isNotEmpty
                              ? NetworkImage("${auth.imgurl}/${img[0]}")
                              : NetworkImage("http://example.com/default_image.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(e['propName']),
                    subtitle: Text("Featured: ${e['featured']}"),
                    trailing: Wrap(
                      spacing: 10,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.green),
                          onPressed: () {
                            id = e['id'];
                            _propNameController.text = e['propName'];
                            videolink.text = e['videolink'] ?? '';
                            base64Image = img;
                            imguploads = img;
                            setState(() {});
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await auth.delete(e['id'], 'api/property/proplisting/del', null);
                            getProp();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
                : Center(child: Text("No events found.")),
          ],
        ),
      ),
    );
  }

/*  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children: [
              SizedBox(height: 100,),
              Column(
                children: [
                  Row(
                    children: [
                      forms(
                        hint: 'Event',
                        label: "Event Name",
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

                     *//* base64Image.isNotEmpty
                          ? Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Row(
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
                        ),
                      ) // Display image using base64 string
                          : Text('No image selected'),*//*

                      base64Image.isNotEmpty
                          ? Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: base64Image.map((e) => Container(
                              margin: EdgeInsets.all(2),
                              width: 150,
                              height: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: e.length > 30 ? e : "${auth.imgurl}/$e",
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          color: Colors.white,
                                        ),
                                      ),
                                      // errorWidget: (context, url, error) => Icon(Icons.error),
                                      errorWidget: (context, url, error) => RetryableImage(imagePath: "${auth.imgurl}/$e", baseUrl: "${auth.imgurl}/$e"),
                                    ),
                                    Positioned(
                                      top: 4,
                                      right: 4,
                                      child: InkWell(
                                        onTap: () async {
                                          var resu = await auth.delete(e['id'], 'api/property/proplisting/del', "$e");
                                        },
                                        child: Icon(Icons.close, color: Colors.redAccent),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )).toList(),
                          ),
                        ),
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
                            "featured":_selectedValue,
                            "type":type,
                            "images":imguploads
                          };

                          print(propdata);
                          var resu = await auth.saveMany(propdata,'/api/property/proplisting/add');
                          // print(resu);
                          // var resu = await auth.saveMany(propdata,'/api/property/proplisting/save');
                          // setState(() {
                          //   returned = resu;
                          // });
                          // // print(resu);
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

                  *//*Text('Listings',style: TextStyle(color: Colors.black),),
          Text('${returned}'),*//*
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
  }*/
}
