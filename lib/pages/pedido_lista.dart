import 'package:fancy_dialog/FancyAnimation.dart';
import 'package:fancy_dialog/FancyGif.dart';
import 'package:fancy_dialog/FancyTheme.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:farmacia1/models/productos_model.dart';
import 'package:flutter/material.dart';

class Pedidos extends StatefulWidget {
  final List<ProductosModel> _pedidos;

  Pedidos(this._pedidos);

  @override
  _PedidosState createState() => _PedidosState(this._pedidos);
}

class _PedidosState extends State<Pedidos> {
  _PedidosState(this._pedidos);
  final _scrollController = ScrollController();
  var _firstScroll = true;
  bool _enabled = false;

  List<ProductosModel> _pedidos;

  Container pagoTotal(List<ProductosModel> _pedidos) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(left: 120),
      height: 70,
      width: 400,
      color: Colors.grey[200],
      child: Row(
        children: <Widget>[
          Text("Total:  \S/.${valorTotal(_pedidos)}",
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.black))
        ],
      ),
    );
  }

  String valorTotal(List<ProductosModel> listaProductos) {
    double total = 0.0;

    for (int i = 0; i < listaProductos.length; i++) {
      total = total + listaProductos[i].precio * listaProductos[i].cantidad;
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.medical_services),
            onPressed: null,
            color: Colors.white,
          )
        ],
        title: Text('Detalle',
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              _pedidos.length;
            });
          },
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: GestureDetector(
          onVerticalDragUpdate: (details) {
            if (_enabled && _firstScroll) {
              _scrollController
                  .jumpTo(_scrollController.position.pixels - details.delta.dy);
            }
          },
          onVerticalDragEnd: (_) {
            if (_enabled) _firstScroll = false;
          },
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _pedidos.length,
                itemBuilder: (context, index) {
                  final String imagen = _pedidos[index].imagen;
                  var item = _pedidos[index];
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                  width: 100,
                                  height: 100,
                                  child: new Image.asset(
                                      "assets/images/$imagen",
                                      fit: BoxFit.contain),
                                )),
                                Column(
                                  children: <Widget>[
                                    Text(item.nombre,
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                            color: Colors.black)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: 120,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.blue[200],
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 6.0,
                                                  color: Colors.lightBlue[400],
                                                  offset: Offset(0.0, 1.0),
                                                )
                                              ],
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(50.0),
                                              )),
                                          margin: EdgeInsets.only(top: 20.0),
                                          padding: EdgeInsets.all(2.0),
                                          child: new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 8.0,
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.remove),
                                                onPressed: () {
                                                  _menProducto(index);
                                                  valorTotal(_pedidos);
                                                },
                                                color: Colors.white,
                                              ),
                                              Text(
                                                  '${_pedidos[index].cantidad}',
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 22.0,
                                                      color: Colors.white)),
                                              IconButton(
                                                icon: Icon(Icons.add),
                                                onPressed: () {
                                                  _masProducto(index);
                                                  valorTotal(_pedidos);
                                                },
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                height: 8.0,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 38.0,
                                ),
                                Text(item.precio.toString(),
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.0,
                                        color: Colors.black))
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      )
                    ],
                  );
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              pagoTotal(_pedidos),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 100,
                width: 200,
                padding: EdgeInsets.only(top: 50),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.green,
                  child: Text("PAGAR"),
                  onPressed: () => {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => FancyDialog(
                              title: "ACEPTA PAGAR LA COMPRA",
                              descreption: "Bien pues pague :), Click OK",
                              animationType: FancyAnimation.BOTTOM_TOP,
                              theme: FancyTheme.FANCY,
                              gifPath:
                                  FancyGif.MOVE_FORWARD, //'./assets/walp.png',
                              okFun: () => {print("it's working :)")},
                            ))
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          ))),
    );
  }

  _masProducto(int index) {
    setState(() {
      _pedidos[index].cantidad++;
    });
  }

  _menProducto(int index) {
    setState(() {
      _pedidos[index].cantidad--;
    });
  }
}
