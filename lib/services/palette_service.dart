import 'package:color_palette_generator_app/model/color_palate_model.dart';


class PaletteService {
  static final List<ColorPalette> _palettes = [];

  static List<ColorPalette> getPalettes() {
    return _palettes;
  }

  static void addPalette(ColorPalette palette) {
    _palettes.add(palette);
  }

  static void deletePalette(String id) {
    _palettes.removeWhere((palette) => palette.id == id);
  }
}
