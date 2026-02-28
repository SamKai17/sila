import 'package:client/domain/models/client/client.dart';
import 'package:client/ui/client/home/view_model/home_viewmodel.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClientCard extends StatefulWidget {
  const ClientCard({
    super.key,
    required this.client,
    required this.viewModel,
  });

  final Client client;
  final HomeViewModel viewModel;

  @override
  State<ClientCard> createState() => _ClientCardState();
}

class _ClientCardState extends State<ClientCard> {
  // late bool isSelected;
  @override
  void initState() {
    // print("rebuilding");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("rebuilding inside");
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        child: Card(
          color: widget.viewModel.isSelected(widget.client)
              ? AppPallete.selectedBackground
              : AppPallete.surface,
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
                      child: Text(widget.client.name[0].toUpperCase()),
                      // child: Text('o'),
                    ),
                    if (widget.viewModel.isSelected(widget.client))
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
        onLongPress: () {
          // print("on long pressed");
          if (!widget.viewModel.isSelected(widget.client)) {
            widget.viewModel.addSelectedClient(widget.client);
          } else {
            widget.viewModel.removeSelectedClient(widget.client);
          }
        },
        onTap: () {
          if (!widget.viewModel.selectedMode) {
            context.push(
              '/client/detail/${widget.client.id}',
            );
          } else {
            if (!widget.viewModel.isSelected(widget.client)) {
              widget.viewModel.addSelectedClient(widget.client);
            } else {
              widget.viewModel.removeSelectedClient(widget.client);
            }
          }
        },
      ),
    );
  }
}
