import 'package:flutter_demo/core/scoped_models/login_model.dart';
import 'package:flutter_demo/core/scoped_models/registration_model.dart';
import 'package:flutter_demo/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/views/home_view.dart';
import 'package:flutter_demo/ui/views/registration_view.dart';
import 'package:flutter_demo/ui/widgets/formInputField.dart';
import 'package:flutter_demo/ui/widgets/submit_button.dart';
import 'package:flutter_demo/utils/database_helper.dart';
import 'package:flutter_demo/utils/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                            SizedBox(height: 165.0),
                            InputField(
                              validationHandler: Validator.emailValidator,
                              onSaveHandler: ((value) => model.setEmail(value)),
                              hintText: "Email",
                            ),
                            SizedBox(height: 25.0),
                            InputField(
                              validationHandler: Validator.passValidator,
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
                                  int userID = await model.login();
                                  if (userID != -1) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('OK')));
                                    _setUser(userID);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeView()));
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
                            MaterialButton(
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegistrationView()));
                              },
                              minWidth: double.infinity,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  void _setUser(userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userID', userID);
  }
}
