import 'package:flutter_demo/core/scoped_models/registration_model.dart';
import 'package:flutter_demo/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/widgets/formInputField.dart';
import 'package:flutter_demo/ui/widgets/submit_button.dart';
import 'package:flutter_demo/utils/validators.dart';

class RegistrationView extends StatelessWidget {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<RegistraionModel>(
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
                            Text('Signup',
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
                                  if (await model.insertUser()) {
                                    Navigator.of(context).pushNamed(
                                      'login',
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('Email already exist')));
                                  }
                                }
                              },
                              text: "Register",
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            MaterialButton(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  'login',
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
