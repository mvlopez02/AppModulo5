import 'package:flutter/material.dart';
import 'package:delivery_app/ui/color_palette.dart';

final textInputDecoration = InputDecoration(
    labelStyle: TextStyle(color: ColorPalette.myPalette['text1']),
    focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorPalette.primaryColor,
            width: 2) //! asserts that the value is not null
        //borderRadius:
        ),
    enabledBorder: OutlineInputBorder(
        //enabledBorder: Default border color if it is not clicked
        borderSide:
            BorderSide(color: ColorPalette.myPalette['primary2']!, width: 2)),
    errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2)));
