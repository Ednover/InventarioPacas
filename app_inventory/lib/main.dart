import 'package:app_inventory/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login.dart';
import 'menu.dart';

bool isLogin = false;
Future<void> main() async {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
  ]);
  GoogleSignInAccount _currentUser;
  _googleSignIn.onCurrentUserChanged.listen((account) {
    _currentUser = account;
  });
  _googleSignIn.signInSilently();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges().listen((User user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
      isLogin = true;
    }
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.hasError.toString()),
            );
          } else if (snapshot.hasData) {
            return Menu();
          } else {
            return Login();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}