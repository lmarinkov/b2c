import 'package:flutter/material.dart';

class LanguagesPicker extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagesPicker>
{
  final Set<String> _pickedLanguages = Set<String>();
  final List<String> _languages = <String>[
    'Albanian',
    'Bulgarian',
    'Croatian',
    'Czech',
    'Danish',
    'Dutch',
    //'English',
    'Estonian',
    'Finnish',
    'French',
    'German',
    'Greek',
    'Hungarian',
    'Irish',
    'Italian',
    'Latvian',
    'Lithuanian',
    'Maltese',
    'Norwegian',
    'Polish',
    'Portuguese',
    'Romanian',
    'Russian',
    'Slovak',
    'Slovenian',
    'Spanish',
    'Swedish',
    'Turkish',
    'Ukrainian',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: _getWidgets());
  }

  List<Widget> _getWidgets() {
    List<Widget> result = List<Widget>();
    result.add(
        InputDecorator(
            decoration: const InputDecoration(
              icon: Icon(Icons.translate),
              labelText: '',
              hintText: '',
              contentPadding: EdgeInsets.zero,
            ),
            //isEmpty: null,
            child: DropdownButton<String>(
              value: null,
              hint: Text('Select Languages *'),
              onChanged: (String newValue) {
                setState(() {
                  _pickedLanguages.add(newValue);
                });
              },
              items: _languages.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )
        )
    );
    result.add(
        Wrap( children:
        _pickedLanguages.map<Widget>((String name) {
          return Chip(
            key: ValueKey<String>(name),
            backgroundColor: Colors.lightBlue,
            label: Text(name),
            onDeleted: () {
              setState(() {
                _pickedLanguages.remove(name);
              });
            },
          );
        }).toList()
        )
    );
    return result;
  }
}
