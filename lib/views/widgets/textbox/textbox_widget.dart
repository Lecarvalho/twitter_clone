import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twitter_clone/views/resources/colors.dart';

class TextboxWidget extends StatelessWidget {
  final TextboxType textboxType;
  final int maxLength;
  final String hintText;
  final String labelText;
  final bool showMaxLength;
  final TextEditingController controller;

  TextboxWidget({
    @required this.textboxType,
    @required this.maxLength,
    @required this.controller,
    this.labelText,
    this.hintText,
    this.showMaxLength = false,
  });

  @override
  Widget build(BuildContext context) {
    TextCapitalization textCapitalization = TextCapitalization.none;
    TextInputType keyboardType = TextInputType.text;
    bool isObscure = false;
    int maxLines = 3;

    switch (textboxType) {
      case TextboxType.name:
        textCapitalization = TextCapitalization.words;
        keyboardType = TextInputType.name;
        break;
      case TextboxType.password:
        maxLines = 1;
        isObscure = true;
        break;
      case TextboxType.email:
        keyboardType = TextInputType.emailAddress;
        break;
      default:
        keyboardType = TextInputType.text;
    }

    return TextField(
      textCapitalization: textCapitalization,
      keyboardType: keyboardType,
      obscureText: isObscure,
      maxLines: maxLines,
      minLines: 1,
      maxLength: showMaxLength ? maxLength : null,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
      ],
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: ProjectColors.blueActive),
        ),
      ),
    );
  }
}

enum TextboxType {
  email,
  password,
  name,
  nickname,
}
