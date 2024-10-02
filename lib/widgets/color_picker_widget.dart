
import 'package:flutter/material.dart';

class ColorPickerWidget extends StatelessWidget {
  final ValueChanged<Color> onColorSelected;

  ColorPickerWidget({required this.onColorSelected});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (var color in [Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.orange])
          GestureDetector(
            onTap: () => onColorSelected(color),
            child: Container(
              width: 50,
              height: 50,
              color: color,
            ),
          ),
      ],
    );
  }
}
