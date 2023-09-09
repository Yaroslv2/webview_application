import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_application/application/bloc/network/network_cubit.dart';
import 'package:webview_application/pages/home/home.dart';
import 'package:webview_application/pages/splash_page.dart';
import 'package:webview_application/theme.dart';

void main() {
  final Connectivity connectivity = Connectivity();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<NetworkCubit>(
      create: (_) => NetworkCubit(connectivity: connectivity),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WebView Application',
      theme: theme,
      builder: (context, child) {
        return BlocListener<NetworkCubit, NetworkState>(
          listener: (context, state) {
            switch (state.connection) {
              case ConnectionType.online:
                print("online");
                break;
              case ConnectionType.offline:
                print("offline");
                break;
              default:
                print("unknown");
            }
          },
          child: child,
        );
      },
      home: HomePage(),
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
