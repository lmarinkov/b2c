import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/contact_data.dart';
import 'contact_list_presenter.dart';
import 'contact_detail_view.dart';
import '../../widget/navigation_drawer.dart';


class ContactsPage extends StatelessWidget {
  static const String routeName = '/ContactList';
  final ContactList contactList = ContactList();
  final bool online;

  ContactsPage(this.online);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: online ? new AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
          title: new Text("Interpreters"),
/**
            actions: <Widget>[
                    IconButton( // action button
                    icon: Icon(Icons.search),
                    onPressed: () {
                      Navigator.push(context, new MaterialPageRoute<Null>(
                          settings: const RouteSettings(name: ContactDetailPage.routeName),
                          builder: (BuildContext context) => new ContactsPage(false)
                      ));
                      } ,
                    ),
            ]
    */
        ): new AppBar(title: Text('Interpreters'),
        leading: BackButton(),),
        drawer: new NavigationDrawer(),
        body: contactList,
      );
  }
}


///
///   Contact List
///

class ContactList extends StatefulWidget{
  final _ContactListState _state =  new _ContactListState();
  ContactList({ Key key }) : super(key: key);

  @override
  _ContactListState createState() => _state;

  void filter(ContactFilter contactFilter) {
    _state.filter(contactFilter);
  }
}

class ContactFilter {
  final bool online;
  final bool all;

  ContactFilter(this.online, this.all);
}


class _ContactListState extends State<ContactList> implements ContactListViewContract {
  ContactListPresenter _presenter;

  List<Contact> _contacts;
  List<Contact> _allContacts;

  bool _IsSearching;

  _ContactListState() {
    _presenter = new ContactListPresenter(this);
  }

  void filter(ContactFilter filter)
  {
    setState(() {
      if (filter.online) {
        _contacts.retainWhere((c) => c.state.startsWith('A'));
      }
      else if (filter.all) {
        _contacts = _allContacts;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _IsSearching = true;
    _presenter.loadContacts();
  }


  @override
  void onLoadContactsComplete(List<Contact> items) {

    setState(() {
      _contacts = items;
      _allContacts = new List();
      _allContacts.addAll(items);
      _IsSearching = false;
    });

  }

  @override
  void onLoadContactsError() {
    // TODO: implement onLoadContactsError
  }

  @override
  Widget build(BuildContext context) {

    var widget;

    if(_IsSearching) {
      widget = new Center(
        child: new Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: new CircularProgressIndicator()
        )
      );
    }else {
      widget = new ListView(
            padding: new EdgeInsets.symmetric(vertical: 8.0),
            children: _buildContactList()
          );
    }

    return widget;
  }

  List<_ContactListItem> _buildContactList() {
    return _contacts.map((contact) =>
                          new _ContactListItem(
                            context: context,
                            contact: contact,
                            onTap: () { _showContactPage(context, contact); },
                            onLongPress: () {
                              launch('tel:' + contact.phones[0].number);
                            },
                          ))
                    .toList();
  }

  void _showContactPage(BuildContext context, Contact contact) {
    Navigator.push(context, new MaterialPageRoute<Null>(
      settings: const RouteSettings(name: ContactDetailPage.routeName),
      builder: (BuildContext context) => new ContactDetailPage(contact)
    ));
  }
}


///
///   Contact List Item
///

class _ContactListItem extends ListTile {
  static Phone p;

  _ContactListItem({ @required BuildContext context,
                     @required Contact contact,
                     @required GestureTapCallback onTap,
                     @required GestureTapCallback onLongPress}):
                    
    super(
      leading: new CircleAvatar(
          backgroundImage: new NetworkImage(contact.imageUrl),
          radius: 30,
      ),
      title :  Row(
        children: <Widget>[
                    Text(contact.fullName.substring(0, contact.fullName.length > 30 ? 30 : contact.fullName.length),
                    overflow: TextOverflow.clip,
                    style:DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.2),
                  ),
          Chip(label: Text(contact.state.substring(2)), backgroundColor: contact.state.startsWith('A') ? Colors.green:Colors.red),
        ],
      ),

      subtitle: Row(
        children: <Widget>[
          Chip(label: Text(contact.languages)),
          Chip(label: Text(contact.qualification)),
          Chip(label: Text(contact.distance.toString()+'m', style:DefaultTextStyle.of(context).style.apply(color:Colors.yellow)), backgroundColor: Colors.blue),
        ],
      ),
/**
      trailing: new Row(
        children: [
            new IconButton(icon: const Icon(Icons.phone), onPressed: _call),
        ]
      ),
      */
      onTap: onTap,
      onLongPress: onLongPress
    );


  static void _call() {
    //launch("tel://<phone_number>");
  }

}
