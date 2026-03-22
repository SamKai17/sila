import 'package:client/ui/client/create/view_model/client_create_viewmodel.dart';
import 'package:client/ui/core/ui/custom_button_widget.dart';
import 'package:client/ui/core/ui/custom_field_widget.dart';
import 'package:client/ui/core/ui/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClientCreateScreen extends ConsumerStatefulWidget {
  const ClientCreateScreen({super.key});

  @override
  ConsumerState<ClientCreateScreen> createState() => _ClientCreateScreenState();
}

class _ClientCreateScreenState extends ConsumerState<ClientCreateScreen> {
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
    final isLoading = ref.watch(clientCreateViewModel).isLoading;
    ref.listen(
      clientCreateViewModel,
      (previous, next) {
        next.when(
          data: (data) {
            if (previous != null && previous.hasValue && next.hasValue) {
              if (context.mounted) {
                context.pop();
              }
            }
          },
          error: (error, stackTrace) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('an error happened')));
          },
          loading: () {},
        );
      },
    );
    return Scaffold(
      appBar: AppBar(title: Text("Client Create")),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: isLoading
            ? Center(
                child: LoaderWidget(),
              )
            : Form(
                child: Column(
                  children: [
                    CustomFieldWidget(
                        hintText: 'name', controller: _nameController),
                    SizedBox(height: 32.0),
                    CustomFieldWidget(
                      hintText: 'phone',
                      controller: _phoneController,
                    ),
                    SizedBox(height: 32.0),
                    CustomFieldWidget(
                        hintText: 'city', controller: _cityController),
                    Spacer(),
                    CustomButtonWidget(
                        buttonText: 'save',
                        onPressed: () async {
                          await ref
                              .read(clientCreateViewModel.notifier)
                              .addClient(
                                name: _nameController.text,
                                city: _cityController.text,
                                phone: _phoneController.text,
                              );
                        }),
                  ],
                ),
              ),
      ),
    );
  }
}
