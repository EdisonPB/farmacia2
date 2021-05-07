import 'package:farmacia1/models/productos_model.dart';
import 'package:farmacia1/pages/otra_pagina.dart';
import 'package:farmacia1/pages/pedido_lista.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'App farmacia delivery'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ProductosModel> _productosModel = List<ProductosModel>();

  List<ProductosModel> _listaCarro = List<ProductosModel>();

  @override
  void initState() {
    super.initState();
    _productosDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Icon(
                    Icons.shopping_cart,
                    size: 38,
                  ),
                  if (_listaCarro.length > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Text(
                          _listaCarro.length.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.0),
                        ),
                      ),
                    ),
                ],
              ),
              onTap: () {
                if (_listaCarro.isNotEmpty)
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Pedidos(_listaCarro),
                    ),
                  );
              },
            ),
          )
        ],
      ),
      drawer: Container(
        width: 170.0,
        child: Drawer(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            color: Colors.black,
            child: new ListView(
              padding: EdgeInsets.only(top: 50.0),
              children: <Widget>[
                Container(
                  height: 120,
                  child: new UserAccountsDrawerHeader(
                    accountName: new Text(''),
                    accountEmail: new Text(''),
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                          image: AssetImage('assets/images/api.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                new Divider(),
                new ListTile(
                  title: new Text(
                    'Inicio',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: new Icon(
                    Icons.home,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => OtraPagina(),
                  )),
                ),
                new Divider(),
                new ListTile(
                  title: new Text(
                    'Buscar producto',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: new Icon(
                    Icons.find_in_page,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => OtraPagina(),
                  )),
                ),
                new Divider(),
                new ListTile(
                  title: new Text(
                    'Dirección',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: new Icon(
                    Icons.place,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => OtraPagina(),
                  )),
                ),
                new Divider(),
                new ListTile(
                  title: new Text(
                    'Configuración',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: new Icon(
                    Icons.settings,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => OtraPagina(),
                  )),
                ),
                new Divider(),
                new ListTile(
                  title: new Text(
                    'Salir',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: new FaIcon(
                    FontAwesomeIcons.signOutAlt,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => OtraPagina(),
                  )),
                ),
                new Divider(),
              ],
            ),
          ),
        ),
      ),
      body: _cuadroProductos(),
    );
  }

  GridView _cuadroProductos() {
    return GridView.builder(
      padding: const EdgeInsets.all(4.0),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: _productosModel.length,
      itemBuilder: (context, index) {
        final String image = _productosModel[index].imagen;
        var item = _productosModel[index];
        return Card(
            elevation: 4.0,
            child: Stack(
              fit: StackFit.loose,
              alignment: Alignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: new Image.asset("assets/images/$image",
                          fit: BoxFit.contain),
                    ),
                    Text(
                      item.nombre,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          item.precio.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23.0,
                              color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 8.0,
                            bottom: 8.0,
                          ),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              child: (!_listaCarro.contains(item))
                                  ? Icon(
                                      Icons.shopping_cart,
                                      color: Colors.green,
                                      size: 38,
                                    )
                                  : Icon(
                                      Icons.shopping_cart,
                                      color: Colors.red,
                                      size: 38,
                                    ),
                              onTap: () {
                                setState(() {
                                  if (!_listaCarro.contains(item))
                                    _listaCarro.add(item);
                                  else
                                    _listaCarro.remove(item);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ));
      },
    );
  }

  void _productosDb() {
    var list = <ProductosModel>[
      ProductosModel(
        nombre: 'Alcohol de 96',
        imagen: 'alcohol.png',
        precio: 15,
      ),
      ProductosModel(
        nombre: 'Sal de Andrews',
        imagen: 'andrews.png',
        precio: 1,
      ),
      ProductosModel(
        nombre: 'Aspirina',
        imagen: 'aspirina.png',
        precio: 5,
      ),
      ProductosModel(
        nombre: 'Ibuprofeno',
        imagen: 'ibuprofeno.png',
        precio: 2,
      ),
      ProductosModel(
        nombre: 'Paracetamol',
        imagen: 'paracetamol.png',
        precio: 2,
      ),
      ProductosModel(
        nombre: 'Pomada antiinflamatoria',
        imagen: 'quemadura.png',
        precio: 34,
      ),
      ProductosModel(
        nombre: 'Sal rehidratante',
        imagen: 'rehidratante.png',
        precio: 2,
      ),
      ProductosModel(
        nombre: 'Vitamina C',
        imagen: 'vitaminac.png',
        precio: 43,
      ),
    ];

    setState(() {
      _productosModel = list;
    });
  }
}
