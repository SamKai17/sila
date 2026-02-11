import 'package:client/domain/models/client/client.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class ClientCard extends StatefulWidget {
  const ClientCard({super.key, required this.client});
  final Client client;

  @override
  State<ClientCard> createState() => _ClientCardState();
}

class _ClientCardState extends State<ClientCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        child: Card(
          color: AppPallete.surface,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 32.0,
                      backgroundColor: AppPallete.avatarBackground,
                      foregroundColor: AppPallete.primary,
                      child: Text('O'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: AppPallete.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          color: Colors.black,
                          size: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 18.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.client.name,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: AppPallete.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.client.phone,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: AppPallete.greyText,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
        onLongPress: () {},
        onTap: () {},
      ),
    );
  }
}
