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

class AddGallery extends StatefulWidget {
  const AddGallery({super.key});

  @override
  State<AddGallery> createState() => _AddGalleryState();
}

class _AddGalleryState extends State<AddGallery> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  var _selectedCategory = 'NO';
  var type = 'Gallery';

  var id;
  List galleryItems = [];
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

  getGalleryItems() async {
    var resu = await auth.getvalues("property/proplisting/list");
    setState(() {
      galleryItems = resu;
    });
  }

  @override
  void initState() {
    super.initState();
    getGalleryItems();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Gallery Item'),
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
                    Text('Gallery Details', style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: forms(
                            hint: 'Title',
                            label: "Image Title",
                            txtcontroller: _titleController,
                            onChanged: (String value) {
                              setState(() {
                                _titleController.text = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 16),

                        Row(
                          children: [
                            Text('Coming Soon:', style: TextStyle(fontWeight: FontWeight.w600)),
                            SizedBox(width: 10),
                            DropdownButton<String>(
                              value: _selectedCategory,
                              items: ['YES','NO'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  _selectedCategory = val!;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(width: 16),

                        Expanded(
                          child: forms(
                            hint: 'Description',
                            label: "Image Description",
                            txtcontroller: _descriptionController,
                            onChanged: (String value) {
                              setState(() {
                                _descriptionController.text = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

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
                            Map<String, dynamic> galleryData = {
                              "id": id,
                              "propName": _titleController.text,
                              "description": _descriptionController.text,
                              "category": _selectedCategory,
                              "type": type,
                              "images": imguploads,
                            };

                            var resu = await auth.saveMany(galleryData, '/api/property/proplisting/add');
                            if (resu == 'success') {
                              _titleController.clear();
                              _descriptionController.clear();
                              base64Image.clear();
                              imguploads.clear();
                              id = null;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Gallery item saved successfully."))
                              );
                              getGalleryItems();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                          child: Text('Save Gallery Item'),
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
                    Text('Gallery Items', style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 16),
                    Container(
                      height: 400,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: galleryItems.length,
                        itemBuilder: (context, index) {
                          var item = galleryItems[index];
                          List<dynamic> img = item["images"] == null ? [] : jsonDecode(item['images']);
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  id = item['id'];
                                  _titleController.text = item['propName'];
                                  _descriptionController.text = item['description'] ?? '';
                                  _selectedCategory = item['category'] ?? 'Interior';
                                  imguploads = img;
                                  base64Image = img;
                                  setState(() {});
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item['propName'] ?? '',
                                        style: TextStyle(fontSize: 16),
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
                                        var resu = await auth.delete(item['id'], 'api/property/proplisting/del', null);
                                        getGalleryItems();
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
