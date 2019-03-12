import 'package:flutter/material.dart';

class CertifiedPicker extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => CertifiedPickerState();
}

class CertifiedPickerState extends State<CertifiedPicker>
{
  bool certified = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      key: ValueKey<String>('_certified_'),
      label: Text('Certified Interpreter'),
      selected: certified,
      onSelected: (bool value) {
        setState(() {
          certified = ! certified;
        });
      },
    );
  }
}
