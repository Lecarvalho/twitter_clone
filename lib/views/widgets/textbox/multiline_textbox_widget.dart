import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twitter_clone/views/resources/colors.dart';

class MultilineTextboxWidget extends StatelessWidget {
  final int maxLength;
  final String hintText;
  final TextEditingController controller;
  final String labelText;
  final TextStyle hintStyle;
  final bool withUnderline;

  MultilineTextboxWidget(
      {@required this.maxLength,
      @required this.hintText,
      @required this.controller,
      this.labelText,
      this.hintStyle,
      this.withUnderline = false});

  InputDecoration _buildDecoration() {
    if (withUnderline) {
      return InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: hintStyle,
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: ProjectColors.blueActive),
        ),
      );
    } else {
      return InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: hintStyle,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      );
    }
  }

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
      decoration: _buildDecoration(),
    );
  }
}
