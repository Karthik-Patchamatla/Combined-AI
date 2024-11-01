// home_page.dart
import 'package:flutter/material.dart';
import 'package:combined_ai/components/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music App'),
      ),
      drawer: const DrawerWidget(), // Use the DrawerWidget
      
      );
  }
}
