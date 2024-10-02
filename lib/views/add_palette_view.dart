// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/palette_generator.dart';
import '../viewmodels/color_palette_viewmodel.dart';
import '../model/color_palate_model.dart';

class AddPaletteView extends StatefulWidget {
  @override
  _AddPaletteViewState createState() => _AddPaletteViewState();
}

class _AddPaletteViewState extends State<AddPaletteView> {
  final _formKey = GlobalKey<FormState>();
  final _paletteNameController = TextEditingController();
  List<int> randomColors = PaletteGenerator.generateRandomColors(5);
  int? _selectedColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text('Add New Palette')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _paletteNameController,
                  decoration: InputDecoration(labelText: 'Palette Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
               const SizedBox(height: 20),
                const Text(
                  'Select Colors:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
               const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: randomColors
                      .map(
                        (colorValue) => GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedColor = colorValue;
                            });
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(colorValue),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: _selectedColor == colorValue
                                    ? Colors.black
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final palette = ColorPalette(
                          id: DateTime.now().toString(),
                          name: _paletteNameController.text,
                          colors: randomColors,
                        );

                        print('Added Palette: ${palette.name}');
                        print('Colors: ${palette.colors}');

                        Provider.of<ColorPaletteViewModel>(context,
                                listen: false)
                            .addPalette(palette);
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Add Palette'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
