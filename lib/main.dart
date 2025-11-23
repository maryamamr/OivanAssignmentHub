import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/localization/app_localizations.dart';
import 'di/injector.dart';
import 'features/user_list/presentation/pages/user_list_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injector.init();
  await AppLocalizations.load('en');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: AppLocalizations.appTitle,
        home: const UserListPage(),
      ),
    );
  }
}
