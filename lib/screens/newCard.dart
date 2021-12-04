import 'dart:io';

import 'package:credit_card_project/services/auth.dart';
import 'package:credit_card_project/services/cardServices.dart';
import 'package:credit_card_project/utils/widgetExt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/src/provider.dart';

class NewCard extends StatefulWidget {
  const NewCard({Key? key}) : super(key: key);

  @override
  _NewCardState createState() => _NewCardState();
}

class _NewCardState extends State<NewCard> {
  File? file;
  ImagePicker imagePicker = ImagePicker();

  processImage() {
    setState(() {
      _holderNameController.text = "Yashu Garg";
      _cardNumberController.text = "4532 7991 1360 8687";
      _categoryController.text = "VISA";
      _expirationController.text = "11/2025";
    });
  }

  Future<void> captureImageWithCamera() async {
    imagePicker
        .pickImage(
            source: ImageSource.camera,
            maxHeight: 680,
            maxWidth: 970,
            imageQuality: 50)
        .then((value) => {
              Navigator.pop(context),
              if (value != null)
                {
                  setState(() {
                    file = File(value.path);
                  }),
                  processImage(),
                }
            });
  }

  Future<void> pickImageFromGallery() async {
    imagePicker
        .pickImage(source: ImageSource.gallery, imageQuality: 60)
        .then((value) => {
              Navigator.pop(context),
              if (value != null)
                {
                  setState(() {
                    file = File(value.path);
                  }),
                  processImage(),
                }
            });
  }

  Future takeImage(BuildContext mContext) {
    return showDialog(
      context: mContext,
      builder: (context) {
        return SimpleDialog(
          title: const Text(
            "New Post",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: captureImageWithCamera,
              child: const Text(
                "Capture Image with Camera",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: pickImageFromGallery,
              child: const Text(
                "Select Image from Gallery",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  initState() {
    super.initState();
    if (SchedulerBinding.instance?.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance
          ?.addPostFrameCallback((_) => takeImage(context));
    }
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController _holderNameController = TextEditingController();
  TextEditingController _cardNameController = TextEditingController();
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _expirationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Card"),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Visibility(
                visible: file != null,
                child: file != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(
                          file!,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(),
              ),
              TextButton(
                onPressed: () => takeImage(context),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        file != null ? "Change Image" : "Add card from Image",
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                child: TextFormField(
                  controller: _holderNameController,
                  // ignore: missing_return
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Card Holder Name cannot be empty ';
                    }
                  },
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  decoration: InputDecoration(
                    fillColor: const Color(0xFFF3F3F3),
                    filled: true,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: Icon(Icons.person),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Card Holder\'s Name',
                    labelText: 'Card Holder\'s Name',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 24.0),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                child: TextFormField(
                  controller: _cardNumberController,
                  // ignore: missing_return
                  validator: (val) {
                    if (val!.isEmpty) return 'Card Number cannot be empty ';
                  },
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  decoration: InputDecoration(
                    fillColor: const Color(0xFFF3F3F3),
                    filled: true,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: Icon(Icons.credit_card),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Card Number',
                    labelText: 'Card Number',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 24.0),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                child: TextFormField(
                  controller: _categoryController,
                  // ignore: missing_return
                  validator: (val) {
                    if (val!.isEmpty) return 'Card Category cannot be empty ';
                  },
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  decoration: InputDecoration(
                    fillColor: const Color(0xFFF3F3F3),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Card Type',
                    labelText: 'Card Type',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 24.0),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                child: TextFormField(
                  controller: _expirationController,
                  // ignore: missing_return
                  validator: (val) {
                    if (val!.isEmpty) return 'Expiration Date cannot be empty ';
                  },
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  decoration: InputDecoration(
                    fillColor: const Color(0xFFF3F3F3),
                    filled: true,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: Icon(Icons.calendar_today),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Valid Till',
                    labelText: 'Valid Till',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 24.0),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                child: TextFormField(
                  controller: _cardNameController,
                  // ignore: missing_return
                  validator: (val) {
                    if (val!.isEmpty) return 'Card Name cannot be empty ';
                  },
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  decoration: InputDecoration(
                    fillColor: const Color(0xFFF3F3F3),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Card Name',
                    labelText: 'Card Name',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 24.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            bool res = await CardServices().createCard(
              card: {
                "name": _cardNameController.text,
                "cardExpiration": _expirationController.text,
                "cardHolder": _holderNameController.text,
                "cardNumber": _cardNumberController.text,
                "category": _categoryController.text,
              },
              jwt: context.read<AuthService>().jwt,
            ).catchError((e) {
              WidgetHelper.showWarningDialog(context,
                  title: "Something went Wrong!", content: e);
            });
            if (res) Navigator.pop(context);
          }
        },
      ),
    );
  }
}
