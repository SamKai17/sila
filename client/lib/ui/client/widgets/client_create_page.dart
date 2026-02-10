import 'package:client/core/widgets/custom_button_widget.dart';
import 'package:client/core/widgets/custom_field_widget.dart';
import 'package:client/ui/client/view_model/client_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClientCreatePage extends ConsumerStatefulWidget {
  const ClientCreatePage({super.key});

  @override
  ConsumerState<ClientCreatePage> createState() => _ClientCreatePageState();
}

class _ClientCreatePageState extends ConsumerState<ClientCreatePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

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
                      .addClient(
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
