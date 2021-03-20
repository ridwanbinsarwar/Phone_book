import 'package:flutter/material.dart';
import 'package:flutter_demo/core/services/shared_pred_service.dart';
import 'package:flutter_demo/service_locator.dart';

class Appbar extends StatelessWidget {
  SharedPrefService _sharedPrefService = locator<SharedPrefService>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('PhoneBook'),
      backgroundColor: Colors.blueAccent,
      actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: (String choice) {
            if (choice == 'Logout') {
              _sharedPrefService.removeSharedPrefs();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  'login', (Route<dynamic> route) => false);
              // Navigator.of(context).pushNamed('login');
            }
          },
          itemBuilder: (BuildContext context) {
            return ['Logout'].map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ],
    );
  }
}
