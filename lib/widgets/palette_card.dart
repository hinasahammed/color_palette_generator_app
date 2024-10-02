import 'package:color_palette_generator_app/model/color_palate_model.dart';
import 'package:flutter/material.dart';

class PaletteCard extends StatelessWidget {
  final ColorPalette palette;
  final VoidCallback onDelete;

  const PaletteCard({required this.palette, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(palette.name),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
