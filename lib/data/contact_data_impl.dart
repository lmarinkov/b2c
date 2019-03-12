
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'contact_data.dart';

class RandomUserRepository implements ContactRepository {

  static const _kRandomUserUrl = 'http://api.randomuser.me/?results=30';
  final JsonDecoder _decoder = new JsonDecoder();

  Future<List<Contact>> fetch(){
    return http.get(_kRandomUserUrl)
        .then((http.Response response) {
          final String jsonBody = response.body;
          final statusCode = response.statusCode;

          if(statusCode < 200 || statusCode >= 300 || jsonBody == null) {
            throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
          }

          final contactsContainer = _decoder.convert(jsonBody);
          final List contactItems = contactsContainer['results'];
          List<Contact> contacts = contactItems.map( (contactRaw) => new Contact.fromMap(contactRaw) )
                       .toList();
          contacts.sort((a, b) => a.distance.compareTo(b.distance));
          contacts.sort((a, b) => a.state.compareTo(b.state));
          return contacts;
      });
  }

}
