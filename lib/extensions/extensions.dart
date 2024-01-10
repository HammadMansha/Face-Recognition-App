import 'package:flutter/material.dart';
extension MyExtensions on String{
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}