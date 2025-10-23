import 'package:flutter/material.dart';

class StudifyApp extends StatelessWidget {
  const StudifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Studify',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Placeholder(), // Replace with a welcome screen
        // '/home': (context) => const HomeScreen(),
        // '/details': (context) => const DetailsScreen(),
      },
    );
  }
}