import 'package:flutter/material.dart';
import 'package:ferbsystem/src/components/drawer.dart';
import 'package:ferbsystem/src/models/finance.dart';

class Finances extends StatefulWidget {
  Finances({Key key}) : super(key: key);

  @override
  _FinancesState createState() => _FinancesState();
}

class _FinancesState extends State<Finances> {
  Future<List<Finance>> futureFinance;

  @override
  void initState() {
    super.initState();
    futureFinance = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Controle financeiro',
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            onPressed: () {},
          ),

          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () => Navigator.pushNamed(context, '/finances/form')
          ),
        ],
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
              child: FutureBuilder<List<Finance>>(
                future: futureFinance,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            ListTile(
                                title: Text(snapshot.data[index].description),
                                subtitle:
                                    Text('R\$ ' + snapshot.data[index].value),
                                trailing: snapshot.data[index].type == 'P'
                                    ? Icon(
                                        Icons.add_circle_outline,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.red,
                                      )),
                            Divider(height: 1),
                          ],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: Text(
                          "Não foi possível carregar os dados.",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }

                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(),
    );
  }
}
