import 'package:flutter/material.dart';
import '../../widget/navigation_drawer.dart';
import '../../widget/certified_picker.dart';
import '../../widget/language_picker.dart';


class ProfilePage extends StatelessWidget {
  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("User Profile"),
            ),
        drawer: new NavigationDrawer(),
        body: SafeArea(
            top: false,
            bottom: false,
            child: Form(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 10.0),
                      Text(
                          '* indicates required field',
                          style: Theme.of(context).textTheme.caption
                      ),
                      LanguagesPicker(),
                      const SizedBox(height: 10.0),
                      CertifiedPicker(),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          filled: true,
                          icon: Icon(Icons.person),
                          hintText: 'Please type in your First Name!',
                          labelText: 'First Name *',
                        ),
                        onSaved: null,
                        validator: null,
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          filled: true,
                          icon: Icon(Icons.person),
                          hintText: 'Please type in your Last Name!',
                          labelText: 'Last Name *',
                        ),
                        onSaved: null,
                        validator: null,
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          filled: true,
                          icon: Icon(Icons.phone),
                          hintText: 'Type your phone number!',
                          labelText: 'Phone Number *',
                          prefixText: '',
                        ),
                        keyboardType: TextInputType.phone,
                        onSaved: null,
                        validator: null,
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          filled: true,
                          icon: Icon(Icons.email),
                          hintText: 'Type your email address!',
                          labelText: 'E-mail',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: null,
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          filled: true,
                          icon: Icon(Icons.local_activity),
                          hintText: 'Type the Years of Expirience as Interpreter ',
                          labelText: 'Years of Expierence *',
                          prefixText: '',
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: null,
                        validator: null,
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                )
            )
        ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: null),

    );
  }
}


