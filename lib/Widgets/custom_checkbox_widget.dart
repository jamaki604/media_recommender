import 'package:flutter/material.dart';

class CustomCheckboxWidget extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool) onChanged;

  const CustomCheckboxWidget({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          onChanged: (bool? newValue) {
            if (newValue != null) onChanged(newValue);
          },
        ),
        GestureDetector(
          onTap: () => onChanged(!value),
          child: Text(title),
        ),
      ],
    );
  }
}
