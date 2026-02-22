import 'package:client/domain/models/item/item.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/core/ui/custom_field_widget.dart';
import 'package:client/ui/transaction/create/view_model/transaction_create_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemUpdateScreen extends StatefulWidget {
  const ItemUpdateScreen(
      {super.key,
      required TransactionCreateViewModel this.viewModel,
      required Item this.item});
  final TransactionCreateViewModel viewModel;
  final Item item;

  @override
  State<ItemUpdateScreen> createState() => _ItemUpdateScreenState();
}

class _ItemUpdateScreenState extends State<ItemUpdateScreen> {
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
        title: Text('Update'),
      ),
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
                buttonText: 'Save',
                onPressed: () {
                  widget.viewModel.updateItem(
                    id: widget.item.id,
                    name: _nameController.text,
                    price: double.parse(_priceController.text),
                    quantity: int.parse(_quantityController.text),
                  );
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
