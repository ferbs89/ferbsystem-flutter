import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:ferbsystem/src/repositories/user_repository.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Image(image: AssetImage('assets/images/logo.png'), height: 40),
                          SizedBox(height: 16),
                          LoginForm(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  UserRepository userRepository = UserRepository();

  final _formKey = GlobalKey<FormState>();
  
  final email = TextEditingController(text: 'ferbs89@gmail.com');
  final password = TextEditingController(text: 'fer');

  bool _load = false;

  @override
  void dispose() {
    email.dispose();
    password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: _load ? (
        CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        )
      ) : (
        Column(
          children: <Widget>[
            TextFormField(
              controller: email,
              style: TextStyle(fontSize: 14),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "E-mail",
                contentPadding: EdgeInsets.all(8.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              validator: (value) {
                if (value.isEmpty)
                  return 'Campo obrigatório.';
                
                if (!EmailValidator.validate(value))
                  return 'E-mail inválido.';

                return null;
              },
            ),

            SizedBox(height: 16),

            TextFormField(
              controller: password,
              style: TextStyle(fontSize: 14),
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Senha",
                contentPadding: EdgeInsets.all(8.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              validator: (value) {
                if (value.isEmpty)
                  return 'Campo obrigatório.';

                return null;
              },
            ),

            SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text("Entrar", style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState((){
                      _load = true;
                    });

                    try {
                      await userRepository.login(email.text, password.text);
                      Navigator.pushReplacementNamed(context, '/home');
                    
                    } catch(e) {
                      String _error;

                      if (e.response == null)
                        _error = "Não foi possível se conectar com o servidor.";
                      else
                        _error = "E-mail ou senha inválidos.";

                      Scaffold.of(context).showSnackBar(SnackBar(content: Text(_error)));

                      setState((){
                        _load = false;
                      });
                    }
                  }
                },
              ),
            ),
          
            SizedBox(height: 16),

            SizedBox(
              height: 32,
              child: FlatButton(
                color: Colors.white,
                textColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text("Não tenho cadastro", style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () => Navigator.pushNamed(context, '/register'),
              ),
            ),
          ]
        )
      )
    );
  }
}