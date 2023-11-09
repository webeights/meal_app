import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/screens/tabs.dart';

void main() => runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );

var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.pinkAccent);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ).copyWith(
        colorScheme: kColorScheme,
      ),
      home: const TabsScreen(),
    );
  }
}
