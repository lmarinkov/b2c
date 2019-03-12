import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../widget/navigation_drawer.dart';

class FavoritesPage extends StatelessWidget  {
  static const String routeName = '/favorites';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Favorites')),
        drawer: NavigationDrawer(),
        body: FavoritesPageView(),
    );
  }
}

class FavoritesPageView extends StatefulWidget  {
  static const String routeName = '/favorites';

  @override
  State<StatefulWidget> createState() => FavoritesPageState();
}

class FavoritesPageState extends State<FavoritesPageView> {
  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
      child: MarkdownBody(
        data: '# Favorites Page\n'
            '---\n\n'
            '## List of Favorites Interpreters\n'
            'The list of **favorite interpretes** is created\n'
            'during the **interpreter search**.\n\n'
            '---\n\n'
            '## FireBase\n'
            'The favorites are connected to the realtime database.\n\n'
            'The list will be update in real time. This means that\n'
            'the state and location are updated.\n\n'
            'For the user it is a matter of glancing at this list'
            'and he gets all the information he needs before contacting '
            '**interpreter**\n'
    )));
  }
}