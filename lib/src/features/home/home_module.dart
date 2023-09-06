import 'package:flutter_modular/flutter_modular.dart';
import 'package:pinksecret_front/src/features/home/ui/pages/home_page.dart';

class HomeModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => HomePage());
  }
}
