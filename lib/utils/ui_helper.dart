import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UiHelper{
  static customTextFeild({required TextEditingController controller, required String hintText, required IconData icon}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)
          )
        ),
      ),
    );
  }

  static iconBtn(VoidCallback callback, {required IconData icon}){
    return IconButton(
        onPressed: callback,
        icon: Icon(icon),
    );
  }

}