import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../module/contacts/contact_list_view.dart';
import '../module/events/profile_view.dart';
import '../module/location/location_list_view.dart';
import '../module/favorites/favorites_list_view.dart';
import '../module/search/search_view.dart';
import '../module/help/help_view.dart';

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget findInterpreter = new ListTile(
        leading: new Icon(Icons.search),
        onTap: () => Navigator.popAndPushNamed(context, SearchPage.routeName),
        title: new Text('Find Interpreters'));

    final Widget contactsItem = new ListTile(
        leading: new Icon(Icons.contacts),
        onTap: () => Navigator.popAndPushNamed(context, ContactsPage.routeName),
        title: new Text('Find Interpreters'));

    final Widget favorites = new ListTile(
        leading: new Icon(Icons.star),
        onTap: () => Navigator.popAndPushNamed(context, FavoritesPage.routeName),
        title: new Text('Favorites'));

    final Widget eventsItem = new ListTile(
        leading: new Icon(Icons.event),
        onTap: () => Navigator.popAndPushNamed(context, ProfilePage.routeName),
        title: new Text('My Profile'));

    final Widget help = new ListTile(
        leading: new Icon(Icons.help),
        onTap: () => Navigator.popAndPushNamed(context, HelpPage.routeName),
        title: new Text('Help'));

    final Widget notesItem = new ListTile(
        leading: new Icon(Icons.location_on),
        onTap: () => Navigator.popAndPushNamed(context, LocationPage.routeName),
        title: new Text('Location'));
/**
    final Widget stepsItem = new ListTile(
        leading: new Icon(Icons.collections_bookmark),
        onTap: () {},
        title: new Text('Steps'));

    final Widget authorsItem = new ListTile(
        leading: new Icon(Icons.face),
        onTap: () {},
        title: new Text('Authors'));

    final Widget flutterAuthorsItem = new ListTile(
        leading: new Icon(Icons.account_box),
        onTap: () {},
        title: new Text('Flutter Authors'));
*/
    final Widget usefulLinksItem = new ListTile(
        leading: new Icon(Icons.stars),
        onTap: () =>
            launch('http://dk.b2b-translation.de/'),
        title: new Text('Homepage'));

    final Widget reportIssueItem = new ListTile(
        leading: new Icon(Icons.bug_report),
        onTap: () {},
        title: new Text('Report an issue'));

    final Widget appVersionItem =
        new ListTile(onTap: () {}, title: new Text('Version [α 0.0.1]'));

    return new Drawer(
        child: new ListView(children: <Widget>[
      _createHeader(),
      findInterpreter,
      //contactsItem,
      favorites,
      help,
      eventsItem,
      notesItem,
      new Divider(),
      //stepsItem,
      //authorsItem,
      //flutterAuthorsItem,
      usefulLinksItem,
      new Divider(),
      reportIssueItem,
      appVersionItem
    ]));
  }

  Widget _createHeader() {
    return new DrawerHeader(
        padding: const EdgeInsets.only(top: 0.0),
        decoration: new BoxDecoration(color: Colors.cyan),
        child: new Stack(children: <Widget>[
          Center(child: new Image.asset('images/landing_home.png', fit: BoxFit.contain)),
          new DecoratedBox(
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      begin: const FractionalOffset(0.0, 0.6),
                      end: const FractionalOffset(0.0, 1.0),
                      colors: <Color>[
                const Color(0x00000000),
                const Color(0x70000000)
              ]))),
          new Positioned(
              bottom: 12.0,
              left: 16.0,
              child: new Text("Direct Contact",
                  style: new TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400))),
          new GestureDetector(
              onTap: () =>
                  launch('http://dk.b2b-translation.de/')
          )
        ]));
  }
}
