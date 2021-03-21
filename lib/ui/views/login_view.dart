import 'package:flutter_demo/core/scoped_models/login_model.dart';
import 'package:flutter_demo/core/services/shared_pred_service.dart';
import 'package:flutter_demo/service_locator.dart';
import 'package:flutter_demo/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/widgets/formInputField.dart';
import 'package:flutter_demo/ui/widgets/submit_button.dart';
import 'package:flutter_demo/utils/validators.dart';

class LoginView extends StatelessWidget {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _formKey = GlobalKey<FormState>();
  SharedPrefService _sharedPrefService = locator<SharedPrefService>();

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
        builder: (context, child, model) => Scaffold(
              body: SingleChildScrollView(
                child: Center(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(76.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 165.0),
                            Text('Login',
                                style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.blueGrey[600],
                                )),
                            SizedBox(height: 30.0),
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
                                    _sharedPrefService.setUser(userID);
                                    Navigator.of(context).pushNamed(
                                      'home',
                                    );
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
                                Navigator.of(context).pushNamed(
                                  'signUp',
                                );
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
}
