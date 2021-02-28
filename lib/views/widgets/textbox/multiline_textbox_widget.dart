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
    var inputDecoration = InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: hintStyle,
    );

    if (withUnderline) {
      inputDecoration.copyWith(
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: ProjectColors.blueActive),
        ),
      );
    } else {
      inputDecoration.copyWith(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      );
    }

    return inputDecoration;
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
