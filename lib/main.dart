import 'package:flutter/material.dart';
import 'design/constants/pokedex_theme_data.dart';
import 'di/injection.dart';
import 'route/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const PokedexApp());
}

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key});

  @override
  Widget build(BuildContext context){
    return Material.router(
      theme: PokedexThemeData.pokedexTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoutes.router,
    );
  }
}