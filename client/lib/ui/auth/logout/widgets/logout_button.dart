import 'package:client/ui/auth/login/view_model/auth_viewmodel.dart';
import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppPallete.surface,
      ),
      child: IconButton(
        onPressed: () {
          ref.read(loginViewModel.notifier).logout();
        },
        icon: Icon(Icons.logout),
      ),
    );
  }
}
