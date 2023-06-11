import 'package:flutter/material.dart';

class RedBorderColorCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const RedBorderColorCheckbox({
    required this.value,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<RedBorderColorCheckbox> createState() => _RedBorderColorCheckboxState();
}

class _RedBorderColorCheckboxState extends State<RedBorderColorCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.value,
      onChanged: widget.onChanged,
      activeColor: Colors.white,
      checkColor: const Color(0xFFFFB900),
      shape: const RoundedRectangleBorder(
        side: BorderSide(
            color: Colors.white, width: 2.0), // Set the border color and width
      ),
    );
  }
}
