import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twitter_clone/views/resources/colors.dart';
import 'package:twitter_clone/views/resources/project_icons.dart';

class TextboxWidget extends StatelessWidget {
  final TextboxType textboxType;
  final int maxLength;
  final String? hintText;
  final String? labelText;
  final bool showMaxLength;
  final TextEditingController controller;
  final bool keyboardEnabled;
  final Function()? onLostFocus;
  final bool? isValid;
  final bool showValidIcon;

  TextboxWidget({
    required this.textboxType,
    required this.maxLength,
    required this.controller,
    this.labelText,
    this.hintText,
    this.showMaxLength = false,
    this.keyboardEnabled = true,
    this.onLostFocus,
    this.isValid,
    this.showValidIcon = false,
  });

  final FocusNode focusNode = FocusNode();

  _buildOnLostFocusListenerIfNeeded() {
    if (onLostFocus != null) {
      focusNode.addListener(() {
        if (!focusNode.hasFocus) {
          onLostFocus!();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var textCapitalization = TextCapitalization.none;
    var keyboardType = TextInputType.text;
    var isObscure = false;
    var maxLines = 3;
    var restriction = FilteringTextInputFormatter.allow(RegExp("[\\w|\\s|-]"));
    Icon? suffixIcon;

    if (showValidIcon){
      if (isValid == null){
        suffixIcon = ProjectIcons.isNotConfirmedYet;
      }
      else if (isValid!){
        suffixIcon = ProjectIcons.isConfirmedSolid;
      }
      else {
        suffixIcon = ProjectIcons.notConfirmedSolid;
      }
    }
    
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

    _buildOnLostFocusListenerIfNeeded();

    return TextField(
      focusNode: focusNode,
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
        suffixIcon: suffixIcon,
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
