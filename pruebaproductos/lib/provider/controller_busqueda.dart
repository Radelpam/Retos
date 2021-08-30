import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  bool open = false;
  var heigt = 0.0.obs;
  var color = Colors.white;

  openandclosed() {
    if (open == false) {
      heigt.value = 0.0;
      open = true;
    } else {
      heigt.value = 400.0;
      open = false;
    }
  }
}
