import 'package:flutter/material.dart';

class ToggleButtonsWidget extends StatefulWidget {
  final bool showList;
  final Function(bool) onToggle;
  final String text1;
  final String text2;
  final IconData icon1;
  final IconData icon2;

  ToggleButtonsWidget({
    Key? key,
    required this.showList,
    required this.onToggle,
    required this.text1,
    required this.text2,
    required this.icon1,
    required this.icon2,
  }) : super(key: key);

  @override
  _ToggleButtonsWidgetState createState() => _ToggleButtonsWidgetState();
}

class _ToggleButtonsWidgetState extends State<ToggleButtonsWidget> {
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: [widget.showList, !widget.showList],
      onPressed: (int index) {
        setState(() {
          widget.onToggle(index == 0);
        });
      },
      borderRadius: BorderRadius.circular(8),
      selectedColor: Colors.black,
      fillColor: Colors.grey[200],
      constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width / 2 - 10, minHeight: 40),
      children: <Widget>[
        Row(
          children: [
            Icon(
              widget.icon1,
              color: Colors.grey[500],
            ),
            SizedBox(width: 5),
            Text(widget.text1),
          ],
        ),
        Row(
          children: [
            Icon(
              widget.icon2,
              color: Colors.grey[500],
            ),
            SizedBox(width: 5),
            Text(widget.text2),
          ],
        ),
      ],
    );
  }
}
