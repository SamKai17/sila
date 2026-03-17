import 'package:client/routing/routes.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/core/ui/custom_field_widget.dart';
import 'package:client/ui/transaction/create/view_model/transaction_create_viewmodel.dart';
import 'package:client/ui/transaction/items_edit/view_model/items_edit_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ItemCreateScreen extends ConsumerStatefulWidget {
  const ItemCreateScreen({
    super.key,
    required String this.clientId,
    required this.create,
  });
  final void Function({
    required String name,
    required double price,
    required int quantity,
  }) create;
  final String clientId;
  // final String type;

  @override
  ConsumerState<ItemCreateScreen> createState() => _ItemCreateScreenState();
}

class _ItemCreateScreenState extends ConsumerState<ItemCreateScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          child: Column(
            spacing: 18.0,
            children: [
              CustomFieldWidget(
                hintText: 'name',
                controller: _nameController,
              ),
              Row(
                spacing: 18.0,
                children: [
                  Expanded(
                    child: CustomFieldWidget(
                      hintText: 'price',
                      controller: _priceController,
                    ),
                  ),
                  Expanded(
                    child: CustomFieldWidget(
                      hintText: 'quantity',
                      controller: _quantityController,
                    ),
                  ),
                ],
              ),
              Spacer(),
              CustomButtonWidget(
                buttonText: 'Add',
                onPressed: () {
                  // ref
                  //     .read(
                  //         transactionCreateViewModel(widget.clientId).notifier)
                  //     .addItem(
                  //         name: _nameController.text,
                  //         price: double.parse(_priceController.text),
                  //         quantity: int.parse(_quantityController.text));
                  widget.create(
                    name: _nameController.text,
                    price: double.parse(_priceController.text),
                    quantity: int.parse(_quantityController.text),
                  );
                  // ref.read(itemsEditViewModel([]));
                  if (context.mounted) {
                    context.pop();
                  }
                  // context.goNamed(
                  //   Routes.transactionCreateName,
                  //   pathParameters: {'clientId': widget.clientId},
                  //   queryParameters: {'type': widget.type},
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
