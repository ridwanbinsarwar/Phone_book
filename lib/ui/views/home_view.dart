import 'package:flutter_demo/core/models/contact.dart';
import 'package:flutter_demo/core/scoped_models/home_model.dart';
import 'package:flutter_demo/enums/view_state.dart';
import 'package:flutter_demo/service_locator.dart';
import 'package:flutter_demo/ui/views/base_view.dart';
import 'package:flutter_demo/ui/views/contactForm_view.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class HomeView extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeView> {
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    var myAppModel = locator<HomeModel>();
    if (!myAppModel.loaded) myAppModel.getContacts(_getUser());
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      builder: (context, child, model) => Scaffold(
        body: ListView.builder(
          itemCount: model.contacts.length,
          itemBuilder: _contactCard,
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

  // Widget _ContactList(Future<List<BaseContact>> contacts) {
  //   return Text('');
  // }

  Widget _contactCard(BuildContext context, int index) {
    var myAppModel = locator<HomeModel>();

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(myAppModel.contacts[index].contact.name ?? '',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
          Text(myAppModel.contacts[index].contact.address ?? '',
              style: TextStyle(fontSize: 16.0)),
          // Text(
          //   contacts[index].phone ?? '',
          //   style: TextStyle(fontSize: 18.0)),
        ],
      ),
    );
  }

  // void _showOptions(BuildContext context, int index) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return BottomSheet(
  //         onClosing: () {},
  //         builder: (context) {
  //           return Container(
  //             padding: EdgeInsets.all(10.0),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 Padding(
  //                   padding: const EdgeInsets.all(10.0),
  //                   child: TextButton(
  //                     child: Text(
  //                       'Ligar',
  //                       style: TextStyle(color: Colors.red, fontSize: 20.0),
  //                     ),
  //                     onPressed: () {
  //                       // launch('tel: ${contacts[index].phone}');
  //                       // Navigator.pop(context);
  //                     },
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.all(10.0),
  //                   child: TextButton(
  //                     child: Text(
  //                       'Editar',
  //                       style: TextStyle(color: Colors.red, fontSize: 20.0),
  //                     ),
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                       _showContactPage(contact: contacts[index]);
  //                     },
  //                   ),
  //                 ),
  //                 // Padding(
  //                 //   padding: const EdgeInsets.all(10.0),
  //                 //   child: TextButton(
  //                 //     child: Text(
  //                 //       'Excluir',
  //                 //       style: TextStyle(color: Colors.red, fontSize: 20.0),
  //                 //     ),
  //                 //     onPressed: () {
  //                 //       helper.deleteContact(contacts[index].id);
  //                 //       setState(() {
  //                 //         contacts.removeAt(index);
  //                 //         Navigator.pop(context);
  //                 //       });
  //                 //     },
  //                 //   ),
  //                 // ),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  void _showContactPage({Contact contact}) async {
    // final recContact = await Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => ContactPage(contact: contact)));
    // if (recContact != null) {
    //   if (contact != null) {
    //     await helper.updateContact(recContact);
    //   } else {
    //     await helper.saveContact(recContact);
    //   }
    //   _getAllContacts();
    // }
  }

  Future<int> _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int user = (prefs.getInt('userID') ?? -1);
    return user;
  }
}
