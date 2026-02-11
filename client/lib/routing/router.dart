import 'package:client/routing/routes.dart';
import 'package:client/ui/client/home/widgets/home_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: Routes.home,
    builder: (context, state) => HomeScreen(),
  ),
]);