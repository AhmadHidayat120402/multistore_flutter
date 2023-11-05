import 'package:app_store/bloc/login/login_bloc.dart';
import 'package:app_store/bloc/logout/logout_bloc.dart';
import 'package:app_store/bloc/register/register_bloc.dart';
import 'package:app_store/data/datasources/auth_local_datasource.dart';
import 'package:app_store/pages/auth/auth_page.dart';
import 'package:app_store/pages/dashboard/dashboard_page.dart';
import 'package:app_store/pages/splash/splash_page.dart';
import 'package:app_store/utils/light_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: light,
          home: FutureBuilder(
              future: AuthLocalDatasource().isLogin(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData && snapshot.data!) {
                  return const DashboardPage();
                } else {
                  return const AuthPage();
                }
              })),
    );
  }
}
