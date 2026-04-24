import 'package:client/domain/models/item/item.dart';
import 'package:client/l10n/app_localizations.dart';
import 'package:client/routing/routes.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/core/ui/custom_field_widget.dart';
import 'package:client/ui/core/ui/custom_number_field_widget.dart';
import 'package:client/ui/transaction/create/view_model/transaction_create_viewmodel.dart';
import 'package:client/ui/transaction/items_edit/view_model/items_edit_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ItemUpdateScreen extends ConsumerStatefulWidget {
  const ItemUpdateScreen({
    super.key,
    required Item this.item,
    required String this.clientId,
    required this.update,
  });
  final Item item;
  final String clientId;
  final void Function({
    required String id,
    required String name,
    required double price,
    required int quantity,
  }) update;

  @override
  ConsumerState<ItemUpdateScreen> createState() => _ItemUpdateScreenState();
}

class _ItemUpdateScreenState extends ConsumerState<ItemUpdateScreen> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.item.name);
    _priceController =
        TextEditingController(text: widget.item.price.toString());
    _quantityController =
        TextEditingController(text: widget.item.quantity.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.update),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          child: Column(
            spacing: 18.0,
            children: [
              CustomFieldWidget(
                hintText: AppLocalizations.of(context)!.itemName,
                controller: _nameController,
              ),
              Row(
                spacing: 18.0,
                children: [
                  Expanded(
                    child: CustomNumberFieldWidget(
                      hintText: AppLocalizations.of(context)!.price,
                      controller: _priceController,
                    ),
                  ),
                  Expanded(
                    child: CustomNumberFieldWidget(
                      hintText: AppLocalizations.of(context)!.quantity,
                      controller: _quantityController,
                    ),
                  ),
                ],
              ),
              Spacer(),
              CustomButtonWidget(
                buttonText: AppLocalizations.of(context)!.save,
                onPressed: () {
                  // ref.read(transactionCreateViewModel(widget.clientId).notifier).updateItem(
                  //       id: widget.item.id,
                  //       name: _nameController.text,
                  //       price: double.parse(_priceController.text),
                  //       quantity: int.parse(_quantityController.text),
                  //     );
                  widget.update(
                    id: widget.item.id,
                    name: _nameController.text,
                    price: double.parse(_priceController.text),
                    quantity: int.parse(_quantityController.text),
                  );
                  if (context.mounted) {
                    context.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
