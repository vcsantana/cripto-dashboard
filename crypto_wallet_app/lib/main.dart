import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'core/localization.dart';
import 'core/constants.dart';
import 'presentation/login/login_page.dart';
import 'presentation/register/register_page.dart';
import 'presentation/home/home_page.dart';
import 'data/repositories/auth_repository_impl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: AuthRepositoryImpl().getToken(),
      builder: (context, snapshot) {
        final isLoggedIn = snapshot.data != null && snapshot.data!.isNotEmpty;
        return MaterialApp(
          title: AppConstants.appName,
          theme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          supportedLocales: AppLocalizationsConfig.supportedLocales,
          localizationsDelegates: AppLocalizationsConfig.localizationsDelegates,
          initialRoute:
              isLoggedIn ? AppConstants.routeHome : AppConstants.routeLogin,
          routes: {
            AppConstants.routeLogin: (context) => const LoginPage(),
            AppConstants.routeRegister: (context) => const RegisterPage(),
            AppConstants.routeHome: (context) => const HomePage(),
            // AppConstants.routeProfile: (context) => ProfilePage(),
            // AppConstants.routeCryptoDetail: (context) => CryptoDetailPage(),
          },
        );
      },
    );
  }
}
