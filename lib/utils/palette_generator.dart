import 'dart:math';

class PaletteGenerator {
  static List<int> generateRandomColors(int count) {
    Random random = Random();
    return List.generate(count, (_) => random.nextInt(0xFFFFFF) + 0xFF000000); 
  }
}

   String generateCode() {
    const String characters = "1234567890abcdef";
    String code = "";

    for (int i = 0; i < 6; i++) {
      code += characters[Random().nextInt(characters.length)];
    }

    return "0xFF$code"; 
  }

