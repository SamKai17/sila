import 'package:client/domain/models/item/item.dart';
import 'package:client/l10n/app_localizations.dart';
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
              child: Text(AppLocalizations.of(context)!.quantity),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(AppLocalizations.of(context)!.itemName),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(AppLocalizations.of(context)!.price),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(AppLocalizations.of(context)!.total),
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
                  child: Text('\$${item.price}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('\$${item.price * item.quantity}'),
                ),
              ],
            );
          },
        ).toList(),
      ],
    );
  }
}
