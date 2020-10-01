import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:welvaart/models/user.dart';
import 'package:welvaart/services/firebase_auth_service.dart';
import 'package:welvaart/views/home.dart';
import 'package:welvaart/views/sign_in.dart';

void main() {
  runApp(MultiProvider(providers: [
    Provider(
      create: (_) => FirebaseAuthService(),
    ),
    StreamProvider(
      create: (context) =>
          context.read<FirebaseAuthService>().onAuthStateChanged,
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mijn Overheid',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Consumer<FbUser>(
        builder: (_, user, __) {
          if (user == null)
            return SignInView();
          else
            return HomeScreen();
        },
      ),
    );
  }
}
