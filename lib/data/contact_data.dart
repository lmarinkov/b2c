import 'dart:async';
import 'dart:math';
import 'package:intl/intl.dart';



class Contact {
  static const qualifications = ["CI-C", "CI-H", "CI-L", ];
  static const available = ["A-online", "B-offline"];
  static const languages_ = ["fr", "fi", "de", "bg", "he", "id", "cz"];
  static final DateFormat _formatter = new DateFormat('MMMM d, yyyy');

  final String fullName;
  final String gender;
  final String email;
  final String imageUrl;
  final String imageLargeUrl;
  final String birthday;
  final Location location;
  final List<Phone> phones;
  final String languages;
  final String state;
  final String qualification;
  final int distance;


  const Contact({this.fullName, this.gender, this.email, this.imageUrl, this.imageLargeUrl,
     this.birthday, this.location, this.phones, this.languages, this.state, this.qualification, this.distance});

  Contact.fromMap(Map map) :
                    fullName = "${_capitalize(map['name']['first'])} ${_capitalize(map['name']['last'])}",
                    gender = map['gender'],
                    email = map['email'],
                    imageUrl = map['picture']['thumbnail'],
                    imageLargeUrl = map['picture']['large'],
                    birthday = "Birthday ${_formatter.format(DateTime.parse(map['dob']['date']))}",
                    location = new Location.fromMap(map['location']),
                    phones = <Phone>[
                      new Phone(type: 'Home',   number: map['phone']),
                      new Phone(type: 'Mobile', number: map['cell'])
                    ],
                    languages = _getLanguage(),
                    state = _getState(),
                    qualification = _getQualification(),
                    distance = _getDistance();

  static String _capitalize(String input) {
    return input.substring(0, 1).toUpperCase() + input.substring(1);
  }

  static String _getLanguage() {
    int max = 4;
    int second = Random().nextInt(max) + 1;
    var result = languages_.sublist(0,second).join(",");
    print(result);
    return result;
  }

  static _getState() {
    return available[Random().nextInt(2)];
  }

  static _getQualification() {
    return qualifications[Random().nextInt(3)];
  }

  static _getDistance() {
    return Random().nextInt(10000);
  }
}



class Location {
  final String street;
  final String city;

  const Location({this.street, this.city});

  Location.fromMap(Map<String, dynamic>  map) :
                    street = map['street'],
                    city = map['city'];
}

class Phone {
  final String type;
  final String number;

  const Phone({this.type, this.number});
}


abstract class ContactRepository {
  Future<List<Contact>> fetch();
}

class FetchDataException implements Exception {
  String _message;

  FetchDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}
