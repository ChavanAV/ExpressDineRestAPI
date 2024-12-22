import 'package:express_dine_rest_api/dao/menu_dao.dart';
import 'package:express_dine_rest_api/widgets/toast_msg.dart';
import 'package:flutter/material.dart';

import '../../models/menu_model.dart';
import '../../widgets/button.dart';
import '../../widgets/data_input_card.dart';
import '../../widgets/decoration.dart';

class UpdateItemScreen extends StatefulWidget {
  final Menu menu;
  const UpdateItemScreen({super.key, required this.menu});

  @override
  State<UpdateItemScreen> createState() => _UpdateItemScreenState();
}

class _UpdateItemScreenState extends State<UpdateItemScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController dishNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController itemDescriptionController =
      TextEditingController();

  final MenuDao _menuDao = MenuDao();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    dishNameController.text = widget.menu.dishName;
    priceController.text = widget.menu.price.toString();
    durationController.text = widget.menu.duration.toString();
    itemDescriptionController.text = widget.menu.description;
  }

  void updateFoodItem() async {
    if (_formKey.currentState!.validate() &&
        (dishNameController.text.isNotEmpty &&
            RegExp(r'^[a-z A-Z0-9]+$').hasMatch(dishNameController.text)) &&
        (priceController.text.isNotEmpty &&
            RegExp(r'^(0|[1-9]\d*)(\.\d{1,2})?$')
                .hasMatch(priceController.text)) &&
        (durationController.text.isNotEmpty &&
            RegExp(r'^[0-9]+$').hasMatch(durationController.text))) {
      setState(() {
        loading = true;
      });
      Menu menuModel = Menu(
        mid: widget.menu.mid,
        dishName: dishNameController.text,
        price: double.parse(priceController.text),
        duration: int.parse(durationController.text),
        description: itemDescriptionController.text,
        isSpecial: widget.menu.isSpecial,
        isAvail: widget.menu.isAvail,
      );
      bool? data = await _menuDao.updateMenus(menuModel);
      if (data!) {
        setState(() {
          loading = false;
        });
        showSnac("Menu updated.");
      } else {
        setState(() {
          loading = false;
        });
        showSnac("Something went wrong, try again.");
      }
    } else {
      showSnac("Enter all Valid Details.");
    }
  }

  void _showMenuDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Your menu will be deleted, click Yes to proceed",
              style: foodNameTextStyle),
          alignment: Alignment.center,
          actions: [
            TextButton(
                onPressed: _deleteMenu,
                child: const Text(
                  "Yes",
                  style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "No",
                  style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                )),
          ],
        );
      },
    );
  }

  void _deleteMenu() async {
    Navigator.pop(context);
    try {
      bool? resData = await _menuDao.deleteMenus(widget.menu.mid!);
      if (resData!) {
        showSnac("Menu successfully deleted.");
        if (mounted) Navigator.pop(context);
      } else {
        showSnac("Menu Not deleted.");
      }
    } catch (e) {
      showSnac("Menu Not deleted, something went wrong !!!");
    }
  }

  showSnac(content) {
    Utils().showSnacBar(context, content);
  }

  @override
  void dispose() {
    super.dispose();
    dishNameController.dispose();
    priceController.dispose();
    durationController.dispose();
    itemDescriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update menu",
          style: stationTextStyle,
        ),
        centerTitle: true,
        backgroundColor: allBgClr,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: _showMenuDeleteDialog,
                icon: const Icon(Icons.delete_outline_outlined)),
          )
        ],
      ),
      body: Padding(
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
                        controller: dishNameController,
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
                        controller: durationController,
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
                            value: widget.menu.isSpecial,
                            onChanged: (value) {
                              setState(() {
                                widget.menu.isSpecial = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Currently available",
                              style: TextStyle(fontSize: 16)),
                          Checkbox(
                            value: widget.menu.isAvail,
                            onChanged: (value) {
                              setState(() {
                                widget.menu.isAvail = value!;
                              });
                            },
                          ),
                        ],
                      ),
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
                        ? const Text("Update",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600))
                        : CircularProgressIndicator(color: allBgClr),
                    press: () {
                      updateFoodItem();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
