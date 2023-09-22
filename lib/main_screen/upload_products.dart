import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/utilities/categ_list.dart';
import 'package:ecom/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';

class UploadProducts extends StatefulWidget {
  const UploadProducts({super.key});

  @override
  State<UploadProducts> createState() => _UploadProductsState();
}

class _UploadProductsState extends State<UploadProducts> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late double price;
  late int quantity;
  late String productName;
  late String productDescription;
  late String productID;
  bool processing = false;

  String mainCategValue = 'select category';
  String subCategValue = 'subcategory';
  List<String> subCateList = [];

  final ImagePicker _picker = ImagePicker();

  List<XFile>? imageFileList = [];
  List<String>? imageUrls = [];

  void pickProductImages() async {
    try {
      final pickedImage = await _picker.pickMultiImage(
          maxHeight: 300, maxWidth: 300, imageQuality: 95);

      setState(() {
        imageFileList = pickedImage;
      });
    } catch (e) {
      setState(() {});
    }
  }

  Widget previewImages() {
    if (imageFileList!.isNotEmpty) {
      return ListView.builder(
          itemCount: imageFileList!.length,
          itemBuilder: (context, index) {
            return Image.file(File(imageFileList![index].path));
          });
    } else {
      return const Center(
        child: Text(
          'You have not \n \npicked image yet !',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      );
    }
  }

  void selectedMainCateg(String? value) {
    if (value == 'men') {
      subCateList = men;
    } else if (value == 'women') {
      subCateList = women;
    } else if (value == 'electronics') {
      subCateList = electronics;
    } else if (value == 'accessories') {
      subCateList = accessories;
    } else if (value == 'shoes') {
      subCateList = shoes;
    } else if (value == 'home & garden') {
      subCateList = homeandgarden;
    } else if (value == 'beauty') {
      subCateList = beauty;
    } else if (value == 'kids') {
      subCateList = kids;
    } else if (value == 'bags') {
      subCateList = bags;
    }

    setState(() {
      mainCategValue = value!;
      subCategValue = 'subcategory';
    });
  }

  Future<void> uploadImages() async {
    if (mainCategValue != 'select category' && subCategValue != 'subcategory') {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        if (imageFileList!.isNotEmpty) {
          setState(() {
            processing = true;
          });
          try {
            for (var image in imageFileList!) {
              firebase_storage.Reference ref = firebase_storage
                  .FirebaseStorage.instance
                  .ref('products/${path.basename(image.path)}');

              await ref.putFile(File(image.path)).whenComplete(() async {
                await ref.getDownloadURL().then((value) {
                  imageUrls!.add(value);
                });
              });
            }
          } catch (e) {
            print(e);
          }

          // upload product
        } else {
          myMessageHnadler.showSnackBar(
              _scaffoldKey, 'Please pick product images');
        }
      } else {
        myMessageHnadler.showSnackBar(_scaffoldKey, 'Please fill all details');
      }
    } else {
      myMessageHnadler.showSnackBar(
          _scaffoldKey, 'Please select your category');
    }
  }

  void uploadData() async {
    if (imageUrls!.isNotEmpty) {
      CollectionReference productsRef =
          FirebaseFirestore.instance.collection('products');

      productID = const Uuid().v4();

      await productsRef.doc(productID).set({
        'productid': productID,
        'maincategory': mainCategValue,
        'subcategory': subCategValue,
        'price': price,
        'quantity': quantity,
        'productname': productName,
        'productdescription': productDescription,
        'sid': FirebaseAuth.instance.currentUser!.uid,
        'productimages': imageUrls,
        'discount': 0,
        'instock': quantity
      }).whenComplete(() {
        setState(() {
          processing = false;
          imageFileList = [];
          mainCategValue = 'select category';
          subCateList = [];
          imageUrls = [];
        });
        _formKey.currentState!.reset();
      });
    } else {
      print('no images');
    }
  }

  void uploadProduct() async {
    await uploadImages().whenComplete(() {
      uploadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(children: [
                        Container(
                          color: Colors.blueGrey.shade100,
                          height: MediaQuery.of(context).size.width * 0.5,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Center(
                            child: imageFileList != null
                                ? previewImages()
                                : const Text(
                                    'You have not \n \npicked image yet !',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16),
                                  ),
                          ),
                        ),
                        imageFileList!.isEmpty
                            ? const SizedBox()
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    imageFileList = [];
                                  });
                                },
                                icon: const Icon(Icons.delete_forever)),
                      ]),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.2,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              children: [
                                const Text(
                                  "* select main category",
                                  style: TextStyle(color: Colors.red),
                                ),
                                DropdownButton(
                                    iconSize: 40,
                                    iconEnabledColor: Colors.red,
                                    dropdownColor: Colors.yellow.shade400,
                                    disabledHint: const Text('select category'),
                                    iconDisabledColor: Colors.black,
                                    value: mainCategValue,
                                    items: maincateg

                                        // maincateg
                                        //['men', 'women', 'bags']
                                        .map<DropdownMenuItem<String>>((value) {
                                      return DropdownMenuItem(
                                          value: value, child: Text(value));
                                    }).toList(),
                                    onChanged: (String? value) {
                                      selectedMainCateg(value);
                                    }),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.2,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              children: [
                                const Text(
                                  "* select sub category",
                                  style: TextStyle(color: Colors.red),
                                ),
                                DropdownButton(
                                    menuMaxHeight: 500,
                                    iconSize: 40,
                                    iconEnabledColor: Colors.red,
                                    dropdownColor: Colors.yellow.shade400,
                                    disabledHint: const Text('select category'),
                                    value: subCategValue,
                                    items: subCateList

                                        // maincateg
                                        //['men', 'women', 'bags']
                                        .map<DropdownMenuItem<String>>((value) {
                                      return DropdownMenuItem(
                                          value: value, child: Text(value));
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        subCategValue = value!;
                                      });
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                    child: Divider(
                      color: Colors.yellow,
                      thickness: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter price';
                          } else if (value.isValidPrice() != true) {
                            return 'Please enter valid price';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          price = double.parse(value!);
                        },
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: textFormDecoration.copyWith(
                          labelText: 'price',
                          hintText: 'price..\$',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Quantity';
                          } else if (value.isValidQuantity() != true) {
                            return 'Please enter valid Quantity';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          quantity = int.parse(value!);
                        },
                        keyboardType: TextInputType.number,
                        decoration: textFormDecoration.copyWith(
                          labelText: 'Quantity',
                          hintText: 'Enter Quanity..',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Product name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          productName = value!;
                        },
                        maxLength: 100,
                        maxLines: 3,
                        decoration: textFormDecoration.copyWith(
                          labelText: 'Product name',
                          hintText: 'Enter Product name',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Product Description';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          productDescription = value!;
                        },
                        maxLength: 800,
                        maxLines: 5,
                        decoration: textFormDecoration.copyWith(
                          labelText: 'Product Description',
                          hintText: 'Enter Product description',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            imageFileList!.isEmpty
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          imageFileList = [];
                        });
                      },
                      backgroundColor: Colors.yellow,
                      child: const Icon(
                        Icons.delete_forever,
                        color: Colors.black,
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: FloatingActionButton(
                onPressed: () {
                  pickProductImages();
                },
                backgroundColor: Colors.yellow,
                child: const Icon(
                  Icons.photo_library,
                  color: Colors.black,
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: processing == true
                  ? null
                  : () {
                      uploadProduct();
                    },
              backgroundColor: Colors.yellow,
              child: processing == true
                  ? const CircularProgressIndicator()
                  : const Icon(
                      Icons.upload,
                      color: Colors.black,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: 'price',
  hintText: 'price...\$',
  labelStyle: const TextStyle(color: Colors.purple),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.yellow, width: 1),
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.blueAccent, width: 1),
    borderRadius: BorderRadius.circular(10),
  ),
);

extension QuantityValidator on String {
  bool isValidQuantity() {
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
  }
}

extension PriceValidator on String {
  bool isValidPrice() {
    return RegExp(r'^((([1-9][0-9]*[\.]*)||([0][\.]*))([0-9]{1,2}))$')
        .hasMatch(this);
  }
}
