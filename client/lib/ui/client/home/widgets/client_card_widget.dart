import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class ClientCardWidget extends StatefulWidget {
  const ClientCardWidget({super.key});

  @override
  State<ClientCardWidget> createState() => _ClientCardWidgetState();
}

class _ClientCardWidgetState extends State<ClientCardWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // height: 90.0,
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
                      // alignment: Alignment.bottomRight,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: AppPallete.primary,
                          shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(30.0),
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
                      'oussama',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: AppPallete.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '0769797',
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
