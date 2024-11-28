import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tp_final/CORE/providers/players_provider.dart';
import 'package:flutter_application_tp_final/firebase_options.dart';
import 'package:provider/provider.dart';
import 'CORE/SCREEN/login_screen.dart';

void main() async {
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(
    ChangeNotifierProvider(
      create: (context) => PlayerProvider(),
      child: MaterialApp(
        title: 'Player List App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginScreen(),
      ),
    ),
  );
}