import 'dart:convert';

import 'package:flutter/material.dart';
import '../../reusables/reuseconf.dart';
import '../../reusables/txtform.dart';
import 'dart:html' as html;

class HomeImages extends StatefulWidget {
  const HomeImages({super.key});

  @override
  State<HomeImages> createState() => _HomeImagesState();
}

class _HomeImagesState extends State<HomeImages> {

  var id;
  List homeimages = [];
  List base64Image = [];
  List imguploads = [];
  var returned;
  var selected ;

  final TextEditingController _propNameController = TextEditingController();





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

  List drops = ['Ruiru Villas','Thindigua','Rafiki'];


  getProp() async {
    var resu = await auth.getvalues("property/homeimage/list");
    setState(() {
      homeimages = resu;
    });
    print(homeimages);
  }


  @override
  void initState() {
    super.initState();
    getProp();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [


              Container(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    // value: propNameController.text.isEmpty ? null : propNameController.text,
                    hint: Text("${selected ?? 'select'}"),
                    items: drops.map((e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (String? val) {
                      if (val != null) {
                        setState(() {
                          selected = val;
                          _propNameController.text = val;
                        });
                      }
                    },
                  ),
                ),
              ),
              /*DropdownButton(
              value: _propNameController, // Currently selected value
              icon: const Icon(Icons.arrow_drop_down), // Dropdown icon
    items: drops.map((String item) {
    return DropdownMenuItem<String>(
    value: item,
    child: Text(item),
    );
    }).toList(),
    onChanged: (String? newValue) {
    setState(() {
    _propNameController.text = newValue!;
    })),*/
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
                            var resu = await auth.delete(e['id'],'api/property/homeimage/del',"${e}");
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
                        "images":imguploads
                      };
                      var resu = await auth.saveMany(propdata,'/api/property/homeimage/add');
                      // var resu = await auth.saveMany(propdata,'/api/property/proplisting/save');
                      setState(() {
                        returned = resu;
                      });
                      // print(resu);
                      if(resu == 'success'){
                        _propNameController.clear();
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
            ],
          ),
          Divider(),
          PropertyImageSlider(),
          Divider(),
          Column(
            children: [
              Container(
                height: 400,
                child: ListView.builder(

                    shrinkWrap: true,
                    itemCount: homeimages.length,
                    itemBuilder: (context, index){
                      var e = homeimages[index];
                      List<dynamic> img = e["images"] == null ? [] : jsonDecode(homeimages[index]['images']); //= e["images"] == null ? null: props[index]['images'].split(',');
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {

                              id = e['id'];
                              _propNameController.text = e['propName'];
                              // _locationController.text = e['location'];
                              // _descriptionController.text = e['description'];
                              // _priceController.text = e['price'];
                              // _selectedValue = e['featured'];
                              // _ammenitiesController.text = e['ammenities']??'';
                              imguploads = img;
                              base64Image = img;
                              setState(() {});
                              print(e);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(width: 250, child: Text('${e['propName']}')),
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

                                      var resu = await auth.delete(e['id'],'api/property/homeimage/del',null);
                                      print(resu);
                                      getProp();

                                      // print(vals['id']);
                                      //
                                      // var resu = await auth.delete(vals['id'],'api/user/staff/del',null);
                                      // print(resu);
                                      // getUsers();
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

          ),


        ],
      ),
    );
  }
}


class PropertyImageSlider extends StatefulWidget {
  const PropertyImageSlider({Key? key}) : super(key: key);

  @override
  State<PropertyImageSlider> createState() => _PropertyImageSliderState();
}

class _PropertyImageSliderState extends State<PropertyImageSlider> {
  late PageController _pageController;
  int _currentIndex = 0;

  // Sample data - replace with your actual data
  final List<Map<String, dynamic>> properties = [
    {
      'id': 17381426846196,
      'propName': 'Ruiru Villas',
      'images': ["img_bbd546820250129.webp"]
    },
    {
      'id': 17381428464858,
      'propName': 'Thindigua',
      'images': ["img_70aee5b20250129.webp"]
    },
    {
      'id': 17381429608747,
      'propName': 'Ruiru Villas',
      'images': ["img_14b080520250129.webp"]
    },
  ];

  // Process the data to create a sequential list of all images
  late List<Map<String, dynamic>> sequentialImages;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _processImages();
  }

  void _processImages() {
    // Group properties by name
    Map<String, List<String>> groupedImages = {};

    // First, group all images by property name
    for (var prop in properties) {
      String propName = prop['propName'];
      if (!groupedImages.containsKey(propName)) {
        groupedImages[propName] = [];
      }
      groupedImages[propName]!.addAll(prop['images'].cast<String>());
    }

    // Create sequential list by taking one image at a time from each property
    sequentialImages = [];
    bool hasMoreImages = true;
    int currentImageIndex = 0;

    while (hasMoreImages) {
      hasMoreImages = false;

      // Go through each property
      for (var propName in groupedImages.keys) {
        var images = groupedImages[propName]!;
        // If this property has an image at the current index
        if (currentImageIndex < images.length) {
          sequentialImages.add({
            'propName': propName,
            'image': images[currentImageIndex],
          });
          hasMoreImages = true;
        }
      }
      currentImageIndex++;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextImage() {
    if (_currentIndex < sequentialImages.length - 1) {
      _currentIndex++;
    } else {
      _currentIndex = 0;
    }
    _pageController.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300, // Adjust height as needed
          child: PageView.builder(
            controller: _pageController,
            itemCount: sequentialImages.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Text(
                    sequentialImages[index]['propName'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Image.network(
                      'your_base_url/${sequentialImages[index]['image']}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < sequentialImages.length; i++)
              Container(
                margin: const EdgeInsets.all(4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i == _currentIndex ? Colors.blue : Colors.grey,
                ),
              ),
          ],
        ),
        ElevatedButton(
          onPressed: _nextImage,
          child: const Text('Next Image'),
        ),
      ],
    );
  }
}
// Last edited just now

