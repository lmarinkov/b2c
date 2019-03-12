import 'package:flutter/material.dart';
import 'module/contacts/contact_list_view.dart';
import 'injection/dependency_injection.dart';
import 'module/events/profile_view.dart';
import 'module/location/location_list_view.dart';
import 'module/favorites/favorites_list_view.dart';
import 'module/search/search_view.dart';
import 'module/help/help_view.dart';

void main() {
  Injector.configure(Flavor.PRO);

  runApp(
    new MaterialApp(
      title: 'Direct Contact',
      theme: new ThemeData(
        primarySwatch: Colors.indigo,
      ),
      routes: {
          SearchPage.routeName: (BuildContext context) => SearchPage(),
          ContactsPage.routeName: (BuildContext context) => ContactsPage(true),
          ProfilePage.routeName: (BuildContext context) => ProfilePage(),
          LocationPage.routeName: (BuildContext context) => LocationPage(),
          FavoritesPage.routeName: (BuildContext context) => FavoritesPage(),
          HelpPage.routeName: (BuildContext context) => HelpPage()
      }
    )
  );
}
