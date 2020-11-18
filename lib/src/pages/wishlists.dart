import 'package:flutter/material.dart';
import 'package:ferbsystem/src/components/drawer.dart';
import 'package:ferbsystem/src/models/wishlist.dart';

class Wishlists extends StatefulWidget {
  Wishlists({Key key}) : super(key: key);

  @override
  _WishlistsState createState() => _WishlistsState();
}

class _WishlistsState extends State<Wishlists> {
  Future<List<Wishlist>> futureWishlist;

  @override
  void initState() {
    super.initState();
    futureWishlist = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de desejos', 
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            onPressed: () {},
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
              child: FutureBuilder<List<Wishlist>>(
                future: futureWishlist,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(snapshot.data[index].name),
                                subtitle: snapshot.data[index].description != null ? Text(snapshot.data[index].description) : null,
                                trailing: snapshot.data[index].value != null ? Text('R\$ ${snapshot.data[index].value}') : null,
                                onTap: () {
                                  Navigator.pushNamed(context, '/wishlists/form',
                                    arguments: snapshot.data[index],
                                  );
                                },
                              ),
                              Divider(height: 1),
                            ],
                          );
                        });
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/wishlists/form'),
      ),
    );
  }
}
