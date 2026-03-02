import 'package:client/routing/routes.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/core/ui/custom_field_widget.dart';
import 'package:client/ui/transaction/create/view_model/transaction_create_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemCreateScreen extends StatefulWidget {
  const ItemCreateScreen({
    super.key,
    required TransactionCreateViewModel this.viewModel,
    required String this.clientId,
    required String this.type,
  });
  final TransactionCreateViewModel viewModel;
  final String clientId;
  final String type;

  @override
  State<ItemCreateScreen> createState() => _ItemCreateScreenState();
}

class _ItemCreateScreenState extends State<ItemCreateScreen> {
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
                  widget.viewModel.addItem(
                    clientId: widget.clientId,
                    name: _nameController.text,
                    price: double.parse(_priceController.text),
                    quantity: int.parse(_quantityController.text),
                  );
                  context.goNamed(
                    Routes.transactionCreateName,
                    pathParameters: {'clientId': widget.clientId},
                    queryParameters: {'type': widget.type},
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
