import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawer createState() => _CustomDrawer();
}

class _CustomDrawer extends State<CustomDrawer> {
  String _name;
  String _email;
  String _letter;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  _getUser() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _name = prefs.getString('name');
      _email = prefs.getString('email');
      _letter = _name.substring(0,1).toUpperCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('$_name'),
            accountEmail: Text('$_email'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                '$_letter',
                style: TextStyle(fontSize: 32.0, color: Colors.black),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.account_balance_wallet,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Carteira de ações'),
          ),
          ListTile(
            leading: Icon(
              Icons.calendar_today,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Controle financeiro'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/finances');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.bookmark_border,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Lista de desejos'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/wishlists');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Sair'),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.remove('token');

              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
