import 'package:flutter_demo/core/models/contact.dart';
import 'package:flutter_demo/core/scoped_models/contact_profile_model.dart';
import 'package:flutter_demo/service_locator.dart';
import 'package:flutter_demo/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class ContactProfileView extends StatefulWidget {
  int contactId;
  ContactProfileView(this.contactId);

  @override
  _ContactProfileState createState() => _ContactProfileState();
}

class _ContactProfileState extends State<ContactProfileView> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _formKey = GlobalKey<FormState>();
  BaseContact user = new BaseContact();

  @override
  void initState() {
    super.initState();
    var profileModel = locator<ContactProfileModel>();
    profileModel.getContactInformation(widget.contactId).then((value) {
      setState(() => user = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ContactProfileModel>(
      builder: (context, child, profileModel) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(user.contact.name ?? '',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
            Text(user.contact.address ?? '', style: TextStyle(fontSize: 16.0)),
            ListView.separated(
              shrinkWrap: true,
              itemCount: user.phones.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  color: Colors.amber[100],
                  child:
                      Center(child: Text('Phone: ${user.phones[index].phone}')),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: user.emails.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  color: Colors.amber[100],
                  child:
                      Center(child: Text('Email: ${user.emails[index].email}')),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ],
        ),
      ),
    );
  }
}
