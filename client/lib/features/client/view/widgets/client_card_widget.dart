import 'package:flutter/material.dart';

class ClientCardWidget extends StatelessWidget {
  const ClientCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.0,
      child: Card(child: Text("hellllo")),
    );
  }
}
