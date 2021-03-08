import 'package:flutter_demo/core/scoped_models/login_model.dart';
import 'package:flutter_demo/core/scoped_models/registration_model.dart';
import 'package:flutter_demo/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/widgets/formInputField.dart';
import 'package:flutter_demo/ui/widgets/submit_button.dart';
import 'package:flutter_demo/utils/database_helper.dart';

class LoginView extends StatelessWidget {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _formKey = GlobalKey<FormState>();
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  String email;
  String pass;

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
        builder: (context, child, model) => Scaffold(
              body: SingleChildScrollView(
                child: Center(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(36.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 45.0),
                            InputField(
                              validationHandler: _emailValidator,
                              onSaveHandler: ((value) => model.setEmail(value)),
                              hintText: "Email",
                            ),
                            SizedBox(height: 25.0),
                            InputField(
                              validationHandler: _passValidator,
                              onSaveHandler: ((value) =>
                                  model.setPassword(value)),
                              hintText: 'password',
                              hideText: true,
                            ),
                            SizedBox(
                              height: 35.0,
                            ),
                            SubmitButton(
                              validationHandler: () async {
                                if (_formKey.currentState.validate()) {
                                  // If the form is valid, display a Snackbar.
                                  _formKey.currentState.save();
                                  if (await model.login()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('OK')));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content:
                                          Text('Email password does not match'),
                                      backgroundColor: Colors.red[300],
                                    ));
                                  }
                                }
                              },
                              text: "Login",
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  String _emailValidator(value) {
    if (value.isEmpty) {
      return 'Please enter valid email';
    }
    return null;
  }

  // void _emailFieldBinding(value) => email = value;
  // void _passFieldBinding(value) => pass = value;
  String _passValidator(value) {
    if (value.isEmpty) {
      return 'Password can\'t be empty';
    }
    return null;
  }
}
