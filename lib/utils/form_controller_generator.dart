import 'package:flutter/material.dart';

class FormControllers {
  static Map<String, TextEditingController> controllersFor(List<String> inputs,
      {dynamic data}) {
    Map<String, TextEditingController> map = {};
    for (var element in inputs) {
      map[element] = TextEditingController(
          text: data != null ? data[element].toString() : '');
      if (data != null) {
        map[element]!.selection =
            TextSelection.collapsed(offset: map[element]!.text.length);
      }
    }
    return map;
  }
}
