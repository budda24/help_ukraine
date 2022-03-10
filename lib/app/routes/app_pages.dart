import 'package:get/get.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/add_need_view.dart';
import '../modules/home/views/needs_view.dart';
import '../modules/needs_to_help/bindings/needs_to_help_binding.dart';
import '../modules/needs_to_help/views/needs_to_help_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.AUTH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => AddNeedView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.NEEDS_TO_HELP,
      page: () => NeedsToHelpView(),
      binding: NeedsToHelpBinding(),
    ),
  ];
}
