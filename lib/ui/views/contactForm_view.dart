import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_demo/core/scoped_models/contactForm_model.dart';
import 'package:flutter_demo/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/widgets/formInputField.dart';
import 'package:flutter_demo/ui/widgets/submit_button.dart';
import 'package:flutter_demo/utils/validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactFormView extends StatelessWidget {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _formKey = GlobalKey<FormState>();

  Future<Uint8List> handleImageSelected() async {
    final picker = ImagePicker();
    PickedFile file =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    if (file != null) {
      return File(file.path).readAsBytesSync();
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ContactFormModel>(
      builder: (context, child, model) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 165.0),
                GestureDetector(
                  onTap: () async {
                    Uint8List img = await handleImageSelected();
                    model.setPicture(img);
                  },
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.blueAccent[200],
                    child: model.getPicture() != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.memory(
                              model.getPicture(),
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent.shade100,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            width: 200,
                            height: 200,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 25.0),
                InputField(
                  validationHandler: Validator.defaultValidator,
                  onSaveHandler: ((value) => model.setName(value)),
                  hintText: "Name",
                ),
                SizedBox(height: 25.0),
                InputField(
                  validationHandler: Validator.emailValidator,
                  onSaveHandler: ((value) => model.setEmail(value)),
                  hintText: "Email",
                ),
                SizedBox(height: 25.0),
                InputField(
                  validationHandler: Validator.defaultValidator,
                  onSaveHandler: ((value) => model.setAddress(value)),
                  hintText: 'Address',
                ),
                SizedBox(
                  height: 35.0,
                ),
                InputField(
                  validationHandler: Validator.defaultValidator,
                  onSaveHandler: ((value) => model.setPhone(value)),
                  hintText: 'Phone',
                ),
                SizedBox(
                  height: 35.0,
                ),
                SubmitButton(
                  validationHandler: () async {
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      _formKey.currentState.save();
                      int userID = await _getUser();
                      if (userID != -1) {
                        model.addContact(userID);
                        Navigator.of(context).pushNamed('home');
                      } else {
                        Navigator.of(context).pushNamed('login');
                      }
                    }
                  },
                  text: "Add",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<int> _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int user = (prefs.getInt('userID') ?? -1);
    return user;
  }
}
