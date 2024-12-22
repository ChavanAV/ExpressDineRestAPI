import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final String hintText;
  final void Function(String) onChanged;
  const MySearchBar(
      {Key? key,
      required this.searchController,
      required this.onChanged,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.shade300,
      ),
      child: TextField(
        controller: searchController,
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: hintText,
          contentPadding: const EdgeInsets.only(top: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
