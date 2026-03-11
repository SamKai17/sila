import 'package:client/routing/routes.dart';
import 'package:client/ui/client/update/view_model/client_update_viewmodel.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/core/ui/custom_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClientUpdateScreen extends ConsumerStatefulWidget {
  const ClientUpdateScreen({
    super.key,
    required String this.clientId,
    required String this.name,
    required String this.phone,
    required String this.city,
  });

  final String clientId;
  final String name;
  final String phone;
  final String city;

  @override
  ConsumerState<ClientUpdateScreen> createState() => _ClientUpdateScreenState();
}

class _ClientUpdateScreenState extends ConsumerState<ClientUpdateScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _cityController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.name);
    _phoneController = TextEditingController(text: widget.phone);
    _cityController = TextEditingController(text: widget.city);
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
      appBar: AppBar(title: Text("Client update")),
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
                  await ref.read(clientUpdateViewModel.notifier).updateClient(
                        id: widget.clientId,
                        name: _nameController.text,
                        phone: _phoneController.text,
                        city: _cityController.text,
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
