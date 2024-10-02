import 'package:color_palette_generator_app/views/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/color_palette_viewmodel.dart';
import 'viewmodels/theme_viewmodel.dart';
import 'views/home_view.dart';
import 'theme/app_theme.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ColorPaletteViewModel()..fetchPalettes()),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
      ],
      child: Consumer<ThemeViewModel>(
        builder: (context, themeViewModel, child) {
          return MaterialApp(debugShowCheckedModeBanner: false,
            theme: themeViewModel.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
            home: SplashView(),
          );
        },
      ),
    );
  }
}
