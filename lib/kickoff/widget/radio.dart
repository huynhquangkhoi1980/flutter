import 'package:flutter/material.dart';

class RadioCustom extends StatefulWidget {
  const RadioCustom({
    Key? key,
    required this.data,
    this.selected = '1',
  }) : super(key: key);
  final Map<String, dynamic> data;
  final String selected;

  @override
  // ignore: no_logic_in_create_state
  State<RadioCustom> createState() => _RadioCustomState(
        data: data,
        selected: selected,
      );
}

class _RadioCustomState extends State<RadioCustom> {
  _RadioCustomState({
    required this.data,
    required this.selected,
  });

  final Map<String, dynamic> data;
  late String selected;
  dynamic _value = '1';

  Widget box() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        final key = data.keys.elementAt(index);
        if (selected == 'null') {
          _value = data[data.keys.elementAt(1)];
        }
        return Column(
          children: <Widget>[
            ListTile(
              title: const Text(
                'Radio',
              ),
              leading: Radio(
                value: data[key],
                groupValue: _value,
                onChanged: (dynamic value) {
                  setState(() {
                    _value = value;
                  });
                },
              ),
            ),
            const Divider(
              height: 2,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return box();
  }
}
