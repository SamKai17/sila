import 'package:client/core/widgets/custom_button_widget.dart';
import 'package:client/core/widgets/custom_field_widget.dart';
import 'package:client/features/client/model/client_model.dart';
import 'package:client/features/client/viewmodel/client_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClientUpdatePage extends ConsumerStatefulWidget {
  final ClientModel client;
  const ClientUpdatePage({super.key, required this.client});

  @override
  ConsumerState<ClientUpdatePage> createState() => _ClientUpdatePageState();
}

class _ClientUpdatePageState extends ConsumerState<ClientUpdatePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _cityController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.client.name);
    _phoneController = TextEditingController(text: widget.client.phone);
    _cityController = TextEditingController(text: widget.client.city);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Client Create")),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          child: Column(
            children: [
              CustomFieldWidget(hintText: 'name', controller: _nameController),
              SizedBox(height: 32.0),
              CustomFieldWidget(
                hintText: 'phone',
                controller: _phoneController,
              ),
              SizedBox(height: 32.0),
              CustomFieldWidget(hintText: 'city', controller: _cityController),
              Spacer(),
              CustomButtonWidget(
                buttonText: 'save',
                onPressed: () async {
                  await ref
                      .read(clientListProvider.notifier)
                      .updateClient(
                        id: widget.client.id,
                        name: _nameController.text,
                        phone: _phoneController.text,
                        city: _cityController.text,
                      );
                  if (context.mounted) {
                    Navigator.pop(context);
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
