import 'package:flutter/material.dart';
import 'package:app/views/home.dart';
import 'package:provider/provider.dart';
import 'package:app/viewmodels/change_notifier_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Comic-Relief'),
      home: const HomeView(),
    );
  }
}
