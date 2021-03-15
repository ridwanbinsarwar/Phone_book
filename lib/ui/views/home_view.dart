import 'package:flutter_demo/core/scoped_models/home_model.dart';
import 'package:flutter_demo/enums/view_state.dart';
import 'package:flutter_demo/ui/views/base_view.dart';
import 'package:flutter_demo/ui/views/contactForm_view.dart';
import 'package:flutter_demo/ui/views/registration_view.dart';
import 'package:flutter_demo/ui/widgets/busy_overlay.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      builder: (context, child, model) => Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _getBodyUi(model.state),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ContactFormView()));
          },
          child: Icon(Icons.navigation_rounded),
          backgroundColor: Colors.green,
        ),
      ),
    );
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
