import 'package:flutter/material.dart';

class TextFeildWithTitleWidget extends StatelessWidget {
  final String title;
  final String label;
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;

  final TextEditingController textFieldController;
  const TextFeildWithTitleWidget({
    Key? key,
    required this.title,
    required this.textFieldController,
    required this.label,
    required this.onSaved,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(title),
        TextFormField(
          onSaved: onSaved,
          validator: validator,
          // controller: textFieldController,
        )
      ],
    );
  }
}
