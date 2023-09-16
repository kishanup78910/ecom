import 'dart:io';

import 'package:ecom/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  void uploadProduct() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(price);
      print(quantity);
      print(productName);
      print(productDescription);
      print("validated");
    } else {
      myMessageHnadler.showSnackBar(_scaffoldKey, 'Please fill all details');
    }
  }

  final ImagePicker _picker = ImagePicker();

  List<XFile>? imageFileList = [];

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
    return InkWell(
      onLongPress: () {
        setState(() {
          imageFileList = [];
        });
      },
      child: ListView.builder(
          itemCount: imageFileList!.length,
          itemBuilder: (context, index) {
            return Image.file(File(imageFileList![index].path));
          }),
    );
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
              onPressed: () {
                uploadProduct();
              },
              backgroundColor: Colors.yellow,
              child: const Icon(
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
