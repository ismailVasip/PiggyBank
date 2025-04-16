import 'package:flutter/material.dart';
import 'package:piggy_bank/core/theme/app_pallete.dart';

class MySearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String query;
  final Function(String) onChanged;
  final Function() onClear;
  final String hintText;

  const MySearchBar({
    super.key,
    required this.controller,
    required this.query,
    required this.onChanged,
    required this.onClear,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(color: AppPalette.primaryTextColor),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(Icons.search_sharp),
        suffixIcon: query.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.clear),
                onPressed: onClear,
              )
            : null,
        filled: true,
        fillColor: AppPalette.whiteColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}