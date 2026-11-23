import 'package:material_ui/material_ui.dart';

import 'screens/menu_screen.dart';

void main() => runApp(const CoffeeApp());

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кав\'ярня «Зерно»',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // основний колір макета #6D4C41 (табл. 1.1) — решта відтінків з нього
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6D4C41)),
      ),
      home: const MenuScreen(),
    );
  }
}
