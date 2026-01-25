import 'package:client/features/client/model/client_model.dart';
import 'package:client/features/client/view/pages/client_detail_page.dart';
import 'package:flutter/material.dart';

class ClientCardWidget extends StatelessWidget {
  final ClientModel client;
  const ClientCardWidget({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    print(client.name);
    return Container(
      width: double.infinity,
      child: InkWell(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                CircleAvatar(),
                SizedBox(width: 18.0),
                Column(children: [Text(client.name), Text(client.phone)]),
                Spacer(),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
        onLongPress: () {
          print("long pressed");
        },
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ClientDetailPage(clientId: client.id);
              },
            ),
          );
        },
      ),
    );
  }
}
