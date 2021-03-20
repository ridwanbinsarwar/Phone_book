import 'package:flutter_demo/core/models/contact.dart';
import 'package:flutter_demo/core/scoped_models/contact_profile_model.dart';
import 'package:flutter_demo/service_locator.dart';
import 'package:flutter_demo/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/widgets/appbar.dart';
import 'package:flutter_demo/ui/widgets/formInputField.dart';
import 'package:flutter_demo/ui/widgets/submit_button.dart';
import 'package:flutter_demo/utils/validators.dart';

class ContactProfileView extends StatefulWidget {
  int contactId;
  ContactProfileView({@required this.contactId});

  @override
  _ContactProfileState createState() => _ContactProfileState();
}

class _ContactProfileState extends State<ContactProfileView> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _formKey = GlobalKey<FormState>();
  BaseContact user = new BaseContact();
  bool addPhone = false;
  bool addEmail = false;

  @override
  void initState() {
    super.initState();
    var profileModel = locator<ContactProfileModel>();
    profileModel.getContactInformation(widget.contactId).then((value) {
      setState(() => user = value);
    });
  }

  _delete(String type, int index) {
    setState(() {
      type == 'email'
          ? user.emails.removeAt(index)
          : user.phones.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ContactProfileModel>(
      builder: (context, child, profileModel) => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Appbar(),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(user.contact.name ?? '',
                  style:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
              Text(user.contact.address ?? '',
                  style: TextStyle(fontSize: 16.0)),
              ListView.builder(
                shrinkWrap: true,
                itemCount: user.phones.length,
                itemBuilder: (ctxt, Index) => ListCard(
                  index: Index,
                  type: 'phone',
                  user: user,
                  delteCallback: _delete,
                ),
              ),
              addPhone
                  ? InputField(
                      validationHandler: Validator.emailValidator,
                      onSaveHandler: ((value) => profileModel.setPhone(value)),
                      hintText: "Phone",
                    )
                  : Container(),
              Align(
                  alignment: Alignment.centerRight,
                  child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.blue,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: addPhone
                            ? const Icon(Icons.done)
                            : const Icon(Icons.add),
                        iconSize: 30,
                        highlightColor: Colors.blue[300],
                        color: Colors.white,
                        onPressed: () async {
                          if (addPhone && _formKey.currentState.validate()) {
                            // If the form is valid, display a Snackbar.
                            _formKey.currentState.save();
                            var res =
                                await profileModel.addPhone(widget.contactId);
                            setState(() {
                              user.phones.add(res);
                              addPhone = false;
                            });
                          } else {
                            setState(() {
                              addEmail = false;
                              addPhone = true;
                            });
                          }
                        },
                      ))),
              ListView.builder(
                shrinkWrap: true,
                itemCount: user.emails.length,
                itemBuilder: (ctxt, Index) => ListCard(
                  index: Index,
                  type: 'email',
                  user: user,
                  delteCallback: _delete,
                ),
              ),
              addEmail
                  ? InputField(
                      validationHandler: Validator.emailValidator,
                      onSaveHandler: ((value) => profileModel.setEmail(value)),
                      hintText: "Email",
                    )
                  : Container(),
              Align(
                alignment: Alignment.centerRight,
                child: Ink(
                  decoration: const ShapeDecoration(
                    color: Colors.blue,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: addEmail
                        ? const Icon(Icons.done)
                        : const Icon(Icons.add),
                    iconSize: 30,
                    highlightColor: Colors.blue[300],
                    color: Colors.white,
                    onPressed: () async {
                      if (addEmail && _formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        _formKey.currentState.save();
                        var res = await profileModel.addEmail(widget.contactId);
                        setState(() {
                          user.emails.add(res);
                          addEmail = false;
                        });
                      } else {
                        setState(() {
                          addPhone = false;
                          addEmail = true;
                        });
                      }
                    },
                    // text: addEmail ? "Submit" : "Add Email",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListCard extends StatefulWidget {
  int index;
  String type;
  BaseContact user = new BaseContact();
  final void Function(String, int) delteCallback;

  // void callCallaback() { callback(5); }
  ListCard({this.index, this.type, this.user, this.delteCallback});
  @override
  _listCardState createState() => _listCardState();
}

class _listCardState extends State<ListCard> {
  bool edit = false;
  final _formKey = GlobalKey<FormState>();
  var profileModel = locator<ContactProfileModel>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blueGrey,
      onLongPress: () {
        showMenu<String>(
          context: context,
          position: RelativeRect.fromLTRB(25.0, 25.0, 0.0,
              0.0), //position where you want to show the menu on screen
          items: [
            PopupMenuItem<String>(child: const Text('Edit'), value: '1'),
            PopupMenuItem<String>(child: const Text('Delete'), value: '2'),
          ],
          elevation: 8.0,
        ).then<void>((String itemSelected) {
          if (itemSelected == null) return;

          if (itemSelected == "1") {
            setState(() {
              edit = true;
            });
          } else if (itemSelected == "2") {
            widget.type == 'email'
                ? profileModel
                    .deleteEmail(widget.user.emails[widget.index].email_id)
                : profileModel
                    .deltePhone(widget.user.phones[widget.index].phone_id);
            widget.delteCallback(widget.type, widget.index);
          } else {
            //code here
          }
        });
      },
      child: Card(
        elevation: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    width: 320,
                    child: !edit
                        ? Text(
                            widget.type == 'email'
                                ? widget.user.emails[widget.index].email
                                : widget.user.phones[widget.index].phone,
                            style: TextStyle(fontSize: 22),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: InputField(
                                  initText: widget.type == 'email'
                                      ? widget.user.emails[widget.index].email
                                      : widget.user.phones[widget.index].phone,
                                  validationHandler: widget.type == 'email'
                                      ? Validator.emailValidator
                                      : Validator.defaultValidator,
                                  onSaveHandler: widget.type == 'email'
                                      ? ((value) =>
                                          profileModel.setEmail(value))
                                      : ((value) =>
                                          profileModel.setPhone(value)),
                                  hintText: widget.type == 'email'
                                      ? "email"
                                      : "phone",
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: IconButton(
                                  icon: const Icon(Icons.done),
                                  tooltip: 'update',
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      // If the form is valid, display a Snackbar.
                                      _formKey.currentState.save();

                                      var res = widget.type == 'email'
                                          ? await profileModel.updateEmail(
                                              widget.user.emails[widget.index]
                                                  .email_id)
                                          : await profileModel.updatePhone(
                                              widget.user.phones[widget.index]
                                                  .phone_id);
                                      setState(() {
                                        widget.type == 'email'
                                            ? widget.user.emails[widget.index]
                                                    .email =
                                                profileModel.email.email
                                            : widget.user.phones[widget.index]
                                                    .phone =
                                                profileModel.phone.phone;
                                        edit = false;
                                      });
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 9),
                                child: IconButton(
                                  icon: const Icon(Icons.cancel),
                                  tooltip: 'cancel',
                                  onPressed: () {
                                    setState(() {
                                      edit = false;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                  ),
                ),
              ),
              new Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Visibility(
                  child: IconButton(
                    icon: const Icon(Icons.phone),
                    tooltip: 'call',
                    onPressed: () {},
                  ),
                  visible: widget.type == 'email' ? false : true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: IconButton(
                  icon: const Icon(Icons.message),
                  tooltip: 'message',
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
