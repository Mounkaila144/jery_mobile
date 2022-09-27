import 'package:flutter/material.dart';

class AppDropdownInput<String> extends StatelessWidget {
  final List<String> options;
  final String value;
  final String Function(String) getLabel;
  final void Function(String?) onChanged;

  const AppDropdownInput({
    this.options = const [],
    required this.getLabel,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 15.0),
            labelText: "hintText",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          isEmpty: value == null || value == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isDense: true,
              onChanged: onChanged,
              items: options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(getLabel(value).toString()),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}