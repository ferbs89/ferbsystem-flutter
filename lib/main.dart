import 'package:flutter/material.dart';

import 'package:ferbsystem/src/pages/session.dart';
import 'package:ferbsystem/src/pages/login.dart';
import 'package:ferbsystem/src/pages/register.dart';

import 'package:ferbsystem/src/pages/home.dart';
import 'package:ferbsystem/src/pages/finances.dart';
import 'package:ferbsystem/src/pages/finances_form.dart';

import 'package:ferbsystem/src/pages/wishlists.dart';
import 'package:ferbsystem/src/pages/wishlists_form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ferbsystem',
      theme: ThemeData(
        primaryColor: Color(0xff17496E),
      ),
      initialRoute: '/session',
      routes: {
        '/session': (context) => Session(),
        '/login': (context) => Login(),
        '/register': (context) => Register(),

        '/home': (context) => Home(),
        '/finances': (context) => Finances(),
        '/finances/form': (context) => FinancesForm(),
        '/wishlists': (context) => Wishlists(),
        '/wishlists/form': (context) => WishlistsForm(),
      },
    );
  }
}