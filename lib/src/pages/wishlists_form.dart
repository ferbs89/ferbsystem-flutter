import 'package:ferbsystem/src/repositories/wishlist_repository.dart';
import 'package:flutter/material.dart';
import 'package:ferbsystem/src/models/wishlist.dart';

class WishlistsForm extends StatefulWidget {
  WishlistsForm({Key key}) : super(key: key);

  @override
  _WishlistsFormState createState() => _WishlistsFormState();
}

class _WishlistsFormState extends State<WishlistsForm> {
  final _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final description = TextEditingController();
  final value = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    value.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WishlistRepository wishlistRepository = WishlistRepository();
    final Wishlist item = ModalRoute.of(context).settings.arguments;

    if (item != null) {
      name.text = item.name;
      description.text = item.description;
      value.text = item.value;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de desejos',
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
        elevation: 0.0,
        actions: <Widget>[
          (item != null) ? (
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.white,
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text('Confirmar exclusão do registro?'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('SIM'),
                          onPressed: () async {
                            try {
                              await wishlistRepository.delete(item.id);
                              Navigator.pushReplacementNamed(context, '/wishlists');
                            } catch(e) {
                              Scaffold.of(context).showSnackBar(SnackBar(content: Text('Ocorreu um erro ao excluir o registro.')));
                            }
                          },
                        ),
                        FlatButton(
                          child: Text('NÃO'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            )
          ) : (
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.white,
              onPressed: () {

              }
            )
          )
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Builder(
        builder: (BuildContext context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Text("Nome", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),

                          SizedBox(height: 10),

                          TextFormField(
                            controller: name,
                            textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
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

                          SizedBox(height: 20),

                          Text("Descrição", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),

                          SizedBox(height: 10),

                          TextFormField(
                            controller: description,
                            textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          Text("Valor", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),

                          SizedBox(height: 10),

                          TextFormField(
                            controller: value,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                          ),

                          SizedBox(height: 30),

                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: RaisedButton(
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text("Salvar", style: TextStyle(fontWeight: FontWeight.bold)),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  try {
                                    if (item == null) {
                                      await wishlistRepository.create(name.text, description.text, value.text);
                                    } else {
                                      await wishlistRepository.update(item.id, name.text, description.text, value.text);
                                    }

                                    Navigator.pushReplacementNamed(context, '/wishlists');
                                  
                                  } catch(e) {
                                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Ocorreu um erro ao salvar o registro.')));
                                  }
                                }
                              },
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
          );
        }
      ),
    );
  }
}
