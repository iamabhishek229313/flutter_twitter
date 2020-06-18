import 'package:flutter/material.dart';

class More_button extends StatelessWidget {
  const More_button({
    Key key,
    @required this.choices,
  }) : super(key: key);

  final List<String> choices;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: Icon(
        Icons.more_vert
      ),
      initialValue: choices[0],
      onCanceled: () {
        print('You Have not selected anything');
      },
      tooltip: 'This is tool tip',
      itemBuilder: (BuildContext context) {
        return choices.map((choice) {
          return PopupMenuItem(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)),
    );
  }
}
