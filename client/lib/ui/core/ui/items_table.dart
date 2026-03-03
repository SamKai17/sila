import 'package:client/domain/models/item/item.dart';
import 'package:flutter/material.dart';

class ItemsTable extends StatelessWidget {
  const ItemsTable({super.key, required List<Item> this.items});
  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultColumnWidth: IntrinsicColumnWidth(),
      columnWidths: {1: FlexColumnWidth()},
      children: [
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Qty"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Name"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Price"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Total"),
            ),
          ],
        ),
        ...items.map(
          (item) {
            return TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item.quantity.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item.name),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${item.price}\$'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${item.price * item.quantity}\$'),
                ),
              ],
            );
          },
        ).toList(),
      ],
    );
  }
}
