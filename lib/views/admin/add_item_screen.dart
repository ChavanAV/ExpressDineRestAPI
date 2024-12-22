import 'dart:convert';
import 'dart:typed_data';

import 'package:express_dine_rest_api/dao/menu_dao.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/menu_model.dart';
import '../../widgets/button.dart';
import '../../widgets/data_input_card.dart';
import '../../widgets/decoration.dart';
import '../../widgets/my_card.dart';
import '../../widgets/toast_msg.dart';

class AddItemScreen extends StatefulWidget {
  // final User user;
  final int hid;
  const AddItemScreen({super.key, required this.hid});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController itemDescriptionController =
      TextEditingController();
  String itemName = '';
  String itemPrice = '';
  String deliveryTime = '';
  String itemDescription = '';
  bool loading = false;
  bool isSpecialDish = false;
  bool specialDish = false;
  bool isAvail = true;
  Uint8List? _image;
  String? base64Image;
  final picker = ImagePicker();
  final MenuDao _menuDao = MenuDao();

  Future selectImg() async {
    if (_formKey.currentState!.validate() &&
        (nameController.text.isNotEmpty &&
            RegExp(r'^[a-z A-Z0-9]+$').hasMatch(nameController.text)) &&
        (priceController.text.isNotEmpty &&
            RegExp(r'^[0-9]+$').hasMatch(priceController.text)) &&
        (timeController.text.isNotEmpty &&
            RegExp(r'^[0-9]+$').hasMatch(timeController.text))) {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );
      if (pickedFile != null) {
        final Uint8List imageBytes = await pickedFile.readAsBytes();
        setState(() {
          _image = imageBytes;
          // print("Image bytes : $imageBytes");
          base64Image = base64Encode(imageBytes); // Convert to Base64
        });
      } else {
        showSnac("Image not selected");
      }
    } else {
      showSnac("Enter All Correct Details");
    }
  }

  void showSnac(content) {
    Utils().showSnacBar(context, content);
  }

  void uploadFoodItem() async {
    if (_formKey.currentState!.validate() &&
        (nameController.text.isNotEmpty &&
            RegExp(r'^[a-z A-Z0-9]+$').hasMatch(nameController.text)) &&
        (priceController.text.isNotEmpty &&
            RegExp(r'^[0-9]+$').hasMatch(priceController.text)) &&
        (timeController.text.isNotEmpty &&
            RegExp(r'^[0-9]+$').hasMatch(timeController.text))) {
      setState(() {
        loading = true;
      });
      late Menu menuModel;
      if (base64Image != null) {
        menuModel = Menu(
          dishName: nameController.text,
          price: double.parse(priceController.text),
          duration: int.parse(timeController.text),
          description: itemDescriptionController.text,
          isSpecial: isSpecialDish,
          isAvail: isAvail,
          image: base64Image!,
        );
      } else {
        showSnac("Image not selected !!!");
      }
      try {
        var res = await _menuDao.addMenu(menuModel, widget.hid);
        if (res) {
          setState(() {
            loading = false;
            _image = null;
          });
          showSnac("Item added !!!");
          setState(() {
            nameController.clear();
            priceController.clear();
            timeController.clear();
            itemDescriptionController.clear();
            specialDish = false;
            loading = false;
            isSpecialDish = false;
          });
        } else {
          showSnac("Item not added !!! Retry.");
          setState(() {
            loading = false;
          });
        }
      } catch (e) {
        print("Error is : ${e.toString()}");
        showSnac("Item not added !!! Retry. catch");
        setState(() {
          loading = false;
        });
      }
    } else {
      showSnac("Enter valid information.");
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    priceController.dispose();
    timeController.dispose();
    itemDescriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.all(10),
              decoration: decoration,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DataInputCard(
                      name: "Item Name",
                      controller: nameController,
                      keyBoardType: TextInputType.name,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    DataInputCard(
                      name: "Item Price",
                      controller: priceController,
                      keyBoardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    DataInputCard(
                      name: "Delivery Time",
                      controller: timeController,
                      keyBoardType: TextInputType.number,
                      helperText: "In minutes",
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    DataInputCard(
                      name: "Description",
                      controller: itemDescriptionController,
                      keyBoardType: TextInputType.name,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      children: [
                        const Text("Is this your special item",
                            style: TextStyle(fontSize: 16)),
                        Checkbox(
                          value: isSpecialDish,
                          onChanged: (value) {
                            setState(() {
                              isSpecialDish = !isSpecialDish;
                              if (isSpecialDish) {
                                specialDish = true;
                              } else {
                                specialDish = false;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () {
                              selectImg();
                              setState(() {
                                itemName = nameController.text.toString();
                                itemPrice = priceController.text.toString();
                                deliveryTime = timeController.text.toString();
                                itemDescription =
                                    itemDescriptionController.text.toString();
                              });
                            },
                            child: const Text(
                              "Select Image",
                              style: TextStyle(fontSize: 18),
                            )),
                        (_image != null)
                            ? SizedBox(
                                width: 170,
                                child: MyCard(
                                  padding: myCardPadding,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircleAvatar(
                                        radius: 60,
                                        backgroundImage: MemoryImage(
                                          _image!,
                                        ),
                                      ),
                                      Text(
                                        itemName.toString(),
                                        style: foodNameTextStyle,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        "Rs ${itemPrice.toString()}",
                                        style: foodPriceTextStyle,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        "Delivered in ${deliveryTime.toString()} Min",
                                        style: foodTimeTextStyle,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const Icon(Icons.image),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              width: double.maxFinite,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: MyElevatedButton(
                  btnName: (!loading)
                      ? const Text("Add",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600))
                      : CircularProgressIndicator(color: allBgClr),
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      uploadFoodItem();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
