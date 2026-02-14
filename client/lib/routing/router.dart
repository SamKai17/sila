import 'package:client/routing/routes.dart';
import 'package:client/ui/client/create/view_model/client_create_viewmodel.dart';
import 'package:client/ui/client/create/widgets/client_create_screen.dart';
import 'package:client/ui/client/detail/view_model/client_detail_viewmodel.dart';
import 'package:client/ui/client/detail/widgets/client_detail_screen.dart';
import 'package:client/ui/client/home/view_model/home_viewmodel.dart';
import 'package:client/ui/client/home/widgets/home_screen.dart';
import 'package:client/ui/client/update/view_model/client_update_viewmodel.dart';
import 'package:client/ui/client/update/widgets/client_update_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        // print("building...");
        final viewModel = HomeViewModel(clientRepository: context.read());
        // final viewModel = context.read<HomeViewModel>();
        return HomeScreen(
          viewModel: viewModel,
        );
      },
      routes: [
        GoRoute(
            path: Routes.clientDetail,
            builder: (context, state) {
              // print("reconstruct...");
              // print("detail params: ${state.pathParameters['id']}");
              return ClientDetailScreen(
                viewModel: ClientDetailViewModel(
                  clientId: state.pathParameters['id']!,
                  clientRepository: context.read(),
                ),
              );
            },
            routes: [
              GoRoute(
                path: Routes.clientUpdate,
                builder: (context, state) {
                  // state.
                  // print("update params: ${state.pathParameters['id']}");
                  final clientId = state.pathParameters['id']!;
                  final values = state.extra as Map<String, String>;
                  return ClientUpdateScreen(
                    viewModel: ClientUpdateViewModel(
                      clientId: clientId,
                      clientRepository: context.read(),
                    ),
                    clientId: state.pathParameters['id']!,
                    name: values['name']!,
                    phone: values['phone']!,
                    city: values['city']!,
                  );
                },
              ),
            ]),
        GoRoute(
          path: Routes.clientCreate,
          builder: (context, state) => ClientCreateScreen(
            viewModel: ClientCreateViewModel(clientRepository: context.read()),
          ),
        ),
      ],
    ),
  ],
);
