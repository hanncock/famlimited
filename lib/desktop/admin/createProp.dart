import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../reusables/loading.dart';
import '../../reusables/reuseconf.dart';
import '../../reusables/shimmer.dart';
import '../../reusables/txtform.dart';
import 'dart:html' as html;
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CreateProp extends StatefulWidget {
  const CreateProp({super.key});

  @override
  State<CreateProp> createState() => _CreatePropState();
}

class _CreatePropState extends State<CreateProp> {
  final TextEditingController _propNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ammenitiesController = TextEditingController();
  final TextEditingController videolink = TextEditingController();
  var _selectedValue = 'NO';
  var type = 'Props';

  var id;
  List props = [];
  List base64Image = [];
  List imguploads = [];
  var returned;

  void pickImage() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((e) async {
      final files = uploadInput.files;
      if (files!.isEmpty) return;

      final file = files[0]!;
      final reader = html.FileReader();
      reader.readAsDataUrl(file);

      reader.onLoadEnd.listen((e) {
        final base64String = reader.result as String;
        final mimeType = file.type;

        final base64EncodedImage = base64String.split(',').last;
        final mimeTypeBase64String = 'data:$mimeType;base64,$base64EncodedImage';

        setState(() {
          base64Image.add(mimeTypeBase64String);
          if(id == null) {
            imguploads.add(mimeTypeBase64String);
          }
        });
      });
    });
  }

  getProp() async {
    var resu = await auth.getvalues("property/proplisting/list?type=Props");
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
    _propNameController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _ammenitiesController.dispose();
    videolink.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Property'),
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
                    Text('Property Details', style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: forms(
                            hint: 'Property/Land Name',
                            label: "Property Name",
                            txtcontroller: _propNameController,
                            onChanged: (String value) {
                              setState(() {
                                _propNameController.text = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: forms(
                            linecnt: 5,
                            hint: 'Description',
                            label: "Description",
                            txtcontroller: _descriptionController,
                            onChanged: (String value) {
                              setState(() {
                                _descriptionController.text = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: forms(
                            hint: 'Location',
                            label: "Location",
                            txtcontroller: _locationController,
                            onChanged: (String value) {
                              setState(() {
                                _locationController.text = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: forms(
                            hint: 'Price',
                            label: "Price",
                            txtcontroller: _priceController,
                            onChanged: (String value) {
                              setState(() {
                                _priceController.text = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: forms(
                            hint: 'Amenities',
                            label: "Amenities",
                            txtcontroller: _ammenitiesController,
                            onChanged: (String value) {
                              setState(() {
                                _ammenitiesController.text = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: forms(
                            linecnt: 3,
                            hint: 'Video Link',
                            label: "Video Link",
                            txtcontroller: videolink,
                            onChanged: (String value) {
                              setState(() {
                                videolink.text = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
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
                                    errorWidget: (context, url, error) => RetryableImage(
                                        imagePath: "${auth.imgurl}/$e",
                                        baseUrl: "${auth.imgurl}/$e"
                                    ),
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
                            Map<String, dynamic> propData = {
                              "id": id,
                              "propName": _propNameController.text,
                              "location": _locationController.text,
                              "price": _priceController.text,
                              "description": _descriptionController.text,
                              "ammenities": _ammenitiesController.text,
                              "videolink": videolink.text,
                              "featured": _selectedValue,
                              "type": type,
                              "images": imguploads,
                            };

                            var resu = await auth.saveMany(propData, '/api/property/proplisting/add');
                            if (resu == 'success') {
                              _propNameController.clear();
                              _locationController.clear();
                              _priceController.clear();
                              _descriptionController.clear();
                              _ammenitiesController.clear();
                              videolink.clear();
                              base64Image.clear();
                              imguploads.clear();
                              id = null;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Property saved successfully."))
                              );
                              getProp();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                          child: Text('Save Property'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Property Listings', style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 16),
                    Container(
                      height: 400,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: props.length,
                        itemBuilder: (context, index) {
                          var prop = props[index];
                          List<dynamic> img = prop["images"] == null ? [] : jsonDecode(prop['images']);
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  id = prop['id'];
                                  _propNameController.text = prop['propName'];
                                  _locationController.text = prop['location'];
                                  _priceController.text = prop['price'];
                                  _descriptionController.text = prop['description'];
                                  _ammenitiesController.text = prop['ammenities'] ?? '';
                                  videolink.text = prop['videolink'] ?? '';
                                  _selectedValue = prop['featured'];
                                  imguploads = img;
                                  base64Image = img;
                                  setState(() {});
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            prop['propName'] ?? '',
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            prop['location'] ?? '',
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 80,
                                      width: 80,
                                      margin: EdgeInsets.symmetric(horizontal: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: img.isEmpty
                                              ? NetworkImage("http://example.com/default_image.png")
                                              : NetworkImage("${auth.imgurl}/${img[0]}"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      onPressed: () async {
                                        var resu = await auth.delete(prop['id'], 'api/property/proplisting/del', null);
                                        getProp();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
