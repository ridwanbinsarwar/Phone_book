import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/views/contactForm_view.dart';
import 'package:flutter_demo/ui/views/contact_profile.dart';
import 'package:flutter_demo/ui/views/home_view.dart';
import 'package:flutter_demo/ui/views/login_view.dart';
import 'package:flutter_demo/ui/views/registration_view.dart';

class RouteBuilder {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case 'signUp':
        return MaterialPageRoute(builder: (_) => RegistrationView());
      case 'home':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'addContact':
        return MaterialPageRoute(builder: (_) => ContactFormView());
      case 'details':
        return MaterialPageRoute(
            builder: (_) => ContactProfileView(contactId: args));
      default:
        return null;
    }
  }
}
