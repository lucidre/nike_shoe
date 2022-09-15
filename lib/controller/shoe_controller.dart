import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nike_shoe/constants/style.dart';

class ShoeController extends GetxController {
  final Rx<Color> color = primaryColor.obs;

  updateColor(Color color) {
    this.color.value = color;
  }

  Color get currentColor => color.value;
}
