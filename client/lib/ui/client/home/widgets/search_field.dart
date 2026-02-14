import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key, required this.filter});

  final void Function(String query) filter;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      onChanged: (value) {
        // print(value);
        setState(() {
          widget.filter(value);
        });
      },
      decoration: InputDecoration(
        hintText: "Search",
        contentPadding: EdgeInsets.all(10.0),
        filled: true,
        fillColor: AppPallete.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(Icons.search),
        suffixIcon: _searchController.text.length > 0
            ? IconButton(
                onPressed: () {
                  _searchController.clear();
                  setState(() {
                    widget.filter('');
                  });
                },
                icon: Icon(Icons.close),
              )
            : null,
      ),
    );
  }
}
