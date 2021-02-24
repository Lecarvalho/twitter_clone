import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twitter_clone/views/resources/styles.dart';

class MultilineTextboxWidget extends StatelessWidget {
  final int maxLength;
  final String hintText;
  final TextEditingController controller;

  MultilineTextboxWidget({
    @required this.maxLength,
    @required this.hintText,
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 10,
      minLines: 1,
      autofocus: true,
      keyboardType: TextInputType.multiline,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
      ],
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Styles.h6Gray,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    );
  }
}
