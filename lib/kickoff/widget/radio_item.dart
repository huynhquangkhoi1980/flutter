import 'package:flutter/material.dart';

class RadioItem extends StatelessWidget {
  const RadioItem({
    Key? key,
    required this.label,
    required this.padding,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final dynamic value;
  final ValueChanged<dynamic> onChanged;
  // final String isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            ListTile(
              title: const Text('Male'),
              leading: Radio<dynamic>(
                value: value,
                groupValue: value,
                onChanged: onChanged,
                activeColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
