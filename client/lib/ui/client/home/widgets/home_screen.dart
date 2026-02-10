import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 68,
        leading: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Center(
            child: Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppPallete.surface,
              ),
              child: IconButton(
                onPressed: () async {},
                icon: Icon(Icons.close),
              ),
            ),
          ),
        ),
        title: Text("Sila"),
        titleSpacing: 18.0,
        actions: [
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppPallete.surface,
            ),
            child: IconButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Center(child: Text("Delete this client?")),
                      actions: [
                        Row(
                          children: [
                            Expanded(
                              child: FilledButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Cancel"),
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              child: FilledButton(
                                onPressed: () async {},
                                child: Text("Confirm"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.delete),
            ),
          ),
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppPallete.surface,
            ),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
          ),
          SizedBox(width: 18),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                onChanged: (value) {},
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
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.close),
                  ),
                ),
              ),
              SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
