import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchTextboxWidget extends StatelessWidget {
  final TextEditingController controller;
  SearchTextboxWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: TextField(
        textInputAction: TextInputAction.search,
        autofocus: true,
        controller: controller,
        keyboardType: TextInputType.text,
        textAlignVertical: TextAlignVertical.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(50),
        ],
        decoration: InputDecoration(
          hintText: "Search Twitter",
          prefixIcon: Icon(Icons.search),
          filled: true,
          contentPadding: EdgeInsets.all(5),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
