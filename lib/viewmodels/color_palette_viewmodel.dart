
import 'package:flutter/material.dart';
import '../model/color_palate_model.dart';

class ColorPaletteViewModel extends ChangeNotifier {
  List<ColorPalette> _palettes = [];
  bool _isLoading = false;

  List<ColorPalette> get palettes => _palettes;
  bool get isLoading => _isLoading;

  void fetchPalettes() {
    _palettes = []; 
    notifyListeners();
  }

  void addPalette(ColorPalette palette) {
    _palettes.add(palette);
    notifyListeners();
  }

  void deletePalette(String id) {
    _palettes.removeWhere((palette) => palette.id == id);
    notifyListeners();
  }

  void searchPalettes(String query) {
    _palettes = _palettes.where((palette) => palette.name.contains(query)).toList();
    notifyListeners();
  }
}
