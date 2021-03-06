import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twitter_clone/views/resources/colors.dart';

class TextboxWidget extends StatelessWidget {
  final TextboxType textboxType;
  final int maxLength;
  final String? hintText;
  final String? labelText;
  final bool showMaxLength;
  final TextEditingController controller;
  final bool keyboardEnabled;

  TextboxWidget({
    required this.textboxType,
    required this.maxLength,
    required this.controller,
    this.labelText,
    this.hintText,
    this.showMaxLength = false,
    this.keyboardEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    var textCapitalization = TextCapitalization.none;
    var keyboardType = TextInputType.text;
    var isObscure = false;
    var maxLines = 3;
    var restriction = FilteringTextInputFormatter.allow(RegExp("[\\w|\\s|-]"));

    switch (textboxType) {
      case TextboxType.name:
        textCapitalization = TextCapitalization.words;
        keyboardType = TextInputType.name;
        break;
      case TextboxType.password:
        maxLines = 1;
        isObscure = true;
        restriction = FilteringTextInputFormatter.allow(RegExp("."));
        break;
      case TextboxType.email:
        keyboardType = TextInputType.emailAddress;
        restriction = FilteringTextInputFormatter.allow(RegExp("[\\w|@|.|-]"));
        break;
      case TextboxType.nickname:
        restriction = FilteringTextInputFormatter.allow(RegExp("[\\w|-]"));
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
      enabled: keyboardEnabled,
      maxLength: showMaxLength ? maxLength : null,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
        restriction
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
