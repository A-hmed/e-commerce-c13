import 'package:ecommerce_app/core/di/di.dart';
import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/core/utils/shared_prefrences_helper.dart';
import 'package:ecommerce_app/features/cart/presentaion/screens/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routes_manager/route_generator.dart';

///Dart Basics - OOP - SOLID -
///Data structures - Algorthims - Design Patterns: Creational - Struct - Observer
///Flutter:
/// - Widgets(Stateless - Stateful - Inherited)
/// Widget Keys
/// Firebase(firestore - auth - crashlytics - analytics - app dis. - Cloud Messaging - Storage)
/// Notifications
/// State Management: SetState - Provider - RiverPod - Bloc - Cubit - GetX
/// Local Storage: Firestore - Hive - SharedPref - Flutter secure storage - Sqlfilte
/// Apis: HTTP - DIO - RETROFIT
/// Clean Arch.: - Data - Domain - Ui
/// Advanced: Testing(Unit - Ui)- CI/CD - Flutter Channels - Isolates
/// CI/CD (Github actions - Gitlab Ci Cd - fastlane - jenkins - azure)
/// Streams

///Widget -> VM -> Usecase -> Repository -> DataSource
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  var pref = getIt<SharedPreferencesHelper>();
  runApp(BlocProvider(
    create: (_) => getIt<CartCubit>(),
    child: MainApp(
      isLoggedIn: (await pref.getToken()) != null,
    ),
  ));
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;

  const MainApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: child,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: isLoggedIn ? Routes.mainRoute : Routes.signInRoute,
      ),
    );
  }
}
