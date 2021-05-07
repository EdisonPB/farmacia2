import 'package:flutter/material.dart';

class ProductosModel {
  final String nombre;
  final String imagen;
  final Color color;
  final int precio;
  int cantidad;

  ProductosModel(
      {this.nombre, this.imagen, this.color, this.precio, this.cantidad = 1});
}
