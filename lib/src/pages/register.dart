import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:ferbsystem/src/repositories/user_repository.dart';

class Register extends StatelessWidget {
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
                          RegisterForm(),
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

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  UserRepository userRepository = UserRepository();

  final _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  bool _load = false;

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: _load
          ? CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor),
            )
          : Column(
              children: <Widget>[
                Text(
                  "Criar uma conta",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text("Faça seu cadastro para entrar na plataforma."),
                SizedBox(height: 16),
                TextFormField(
                  controller: name,
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: "Nome",
                    contentPadding: EdgeInsets.all(8.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty)
                      return 'Campo obrigatório.';

                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: email,
                  style: TextStyle(fontSize: 14),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "E-mail",
                    contentPadding: EdgeInsets.all(8.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
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
                    child: Text(
                      "Cadastrar",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          _load = true;
                        });

                        try {
                          await userRepository.register(name.text, email.text, password.text);
                          await userRepository.login(email.text, password.text);
                          Navigator.pushReplacementNamed(context, '/home');

                        } catch (e) {
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Não foi possível realizar o cadastro.")));

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
                    child: Text(
                      "Voltar para o login",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
    );
  }
}
