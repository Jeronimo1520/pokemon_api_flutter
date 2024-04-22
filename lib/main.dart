import 'package:flutter/material.dart';
import 'package:pokemon_api_scroll/views/ListPokemons.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListPokemons()
      ),
    );
  }
}
