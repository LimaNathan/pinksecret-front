import 'package:flutter_modular/flutter_modular.dart';
import 'package:pinksecret_front/src/app_module.dart';
import 'package:pinksecret_front/src/features/home/iteractor/reducers/home_reducer.dart';
import 'package:pinksecret_front/src/features/home/ui/pages/home_page.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void binds(Injector i) {
    super.binds(i);

    i.addSingleton<HomeReducer>(HomeReducer.new);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child('/', child: (_) => HomePage());
  }
}
