import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key, required this.reload});

  final void Function(String) reload;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.only(left: 32.0, right: 32.0, bottom: 24.0),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          widget.reload(value);
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
                    widget.reload('');
                  },
                  icon: Icon(Icons.close),
                )
              : null,
        ),
      ),
    );
  }
}