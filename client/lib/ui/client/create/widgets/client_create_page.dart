import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/core/ui/custom_field_widget.dart';
import 'package:flutter/material.dart';

class ClientCreatePage extends StatefulWidget {
  const ClientCreatePage({super.key});

  @override
  State<ClientCreatePage> createState() => _ClientCreatePageState();
}

class _ClientCreatePageState extends State<ClientCreatePage> {
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
              CustomButtonWidget(buttonText: 'save', onPressed: () async {}),
            ],
          ),
        ),
      ),
    );
  }
}
