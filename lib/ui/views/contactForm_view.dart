import 'package:flutter_demo/core/scoped_models/contactForm_model.dart';
import 'package:flutter_demo/enums/view_state.dart';
import 'package:flutter_demo/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/views/home_view.dart';
import 'package:flutter_demo/ui/views/login_view.dart';
import 'package:flutter_demo/ui/widgets/formInputField.dart';
import 'package:flutter_demo/ui/widgets/submit_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactFormView extends StatelessWidget {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseView<ContactFormModel>(
      builder: (context, child, model) => Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _getBodyUi(model.state),
              SizedBox(height: 165.0),
              InputField(
                validationHandler: _emailValidator,
                onSaveHandler: ((value) => model.setEmail(value)),
                hintText: "Email",
              ),
              SizedBox(height: 25.0),
              InputField(
                validationHandler: _defaultValidator,
                onSaveHandler: ((value) => model.setAddress(value)),
                hintText: 'Address',
              ),
              SizedBox(
                height: 35.0,
              ),
              InputField(
                validationHandler: _defaultValidator,
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomeView()));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginView()));
                    }
                  }
                },
                text: "Add",
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _emailValidator(value) {
    if (value.isEmpty) {
      return 'Please enter valid email';
    }
    return null;
  }

  String _defaultValidator(value) {
    if (value.isEmpty) {
      return 'This field cant be empty';
    }
    return null;
  }

  Future<int> _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int user = (prefs.getInt('userID') ?? -1);
    return user;
  }

  Widget _getBodyUi(ViewState state) {
    switch (state) {
      case ViewState.Busy:
        return CircularProgressIndicator();
      case ViewState.Retrieved:
      default:
        return Text('');
    }
  }
}
