import 'package:flutter/material.dart';
import '../../widget/navigation_drawer.dart';
import '../contacts/contact_list_view.dart';
import '../../widget/language_picker.dart';
import '../../widget/certified_picker.dart';

class SearchPage extends StatelessWidget {
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Find Interpreters'),),
      drawer: NavigationDrawer(),
      body: _getSearchInput(context),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed:()=>_showContactPage(context),)
    );
  }

  void _showContactPage(BuildContext context) {
    Navigator.push(context, new MaterialPageRoute<Null>(
        settings: const RouteSettings(name: ContactsPage.routeName),
        builder: (BuildContext context) => ContactsPage(true)
    ));
  }

  Widget _getSearchInput(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Form(
          child:  SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 10.0),
                Text(
                    '* indicates required field',
                    style: Theme.of(context).textTheme.caption
                ),
                const SizedBox(height: 30.0),
                LanguagesPicker(),
                const SizedBox(height: 20.0),
                CertifiedPicker(),
                const SizedBox(height: 20.0),
                TextFormField(
                  initialValue: '1000',
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.location_searching),
                    hintText: 'Find Interpreters within this distance in Meters',
                    labelText: 'Within distance in Meters',
                    prefixText: '',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: null,
                  validator: null,
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.local_activity),
                    hintText: 'Year of Experience',
                    labelText: 'Year of Experience',
                    prefixText: '',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: null,
                  validator: null,
                ),
              ],
            ),
          )
        ),
    );
  }
}
