import 'package:client/domain/models/client/client.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClientDetailScreen extends StatelessWidget {
  const ClientDetailScreen({super.key, required this.client});
  final Client client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("client"),
        actions: [IconButton(onPressed: () {
          context.go('');
        }, icon: Icon(Icons.edit))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SizedBox(
          // color: Colors.amber,
          width: double.infinity,
          child: Column(
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundColor: AppPallete.avatarBackground,
                foregroundColor: AppPallete.primary,
                child: Text('o'),
              ),
              Text(
                client.name,
                // '',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w900),
              ),
              Text(
                client.city,
                // '',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: AppPallete.greyText,
                ),
              ),
              Text(
                client.phone,
                // '',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: AppPallete.greyText,
                ),
              ),
              SizedBox(height: 32),
              SizedBox(
                height: 70.0,
                width: 70.0,
                child: Card(child: Icon(Icons.swap_horiz)),
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(onPressed: () {}, child: Text('Buy')),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: FilledButton(onPressed: () {}, child: Text('Sell')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
