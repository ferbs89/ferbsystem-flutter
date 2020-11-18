import 'package:flutter/material.dart';

class FinancesForm extends StatefulWidget {
  FinancesForm({Key key}) : super(key: key);

  @override
  _FinancesFormState createState() => _FinancesFormState();
}

class _FinancesFormState extends State<FinancesForm> {
  final _formKey = GlobalKey<FormState>();

  final data = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Controle financeiro',
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
        elevation: 0.0,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
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
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[

                      TextFormField(
                        style: TextStyle(fontSize: 20),
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          hintText: "Valor",
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

                      FlatButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.calendar_today),
                            Text("Selecionar data", style: TextStyle(fontWeight: FontWeight.bold)),
                          ],                          
                        ),
                        onPressed: () async {
                          DateTime datePicker = await showDatePicker(
                            context: context, 
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100)
                          );

                          print(datePicker);
                        },
                      ),

                      TextFormField(
                        readOnly: true,
                        controller: data,
                        style: TextStyle(fontSize: 14),
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          hintText: "Data",
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

                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
