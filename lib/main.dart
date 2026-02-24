import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sos_edi/controller/login_controller.dart';
import 'package:sos_edi/environment.dart';
import 'package:sos_edi/pages/dashboard.dart';
import 'package:sos_edi/pages/auth/login_page.dart';
import 'package:sos_edi/service/localizacion_service.dart';

void main() async {
  await dotenv.load(fileName: Enviroment.filename);
  HttpOverrides.global = MyHttpOverrides();

  final locationService = LocazacionService();

  // Llamar al método para manejar los permisos
  bool hasPermission = await locationService.handleLocationPermission();

  runApp(
    hasPermission == true
        ? const Edi()
        : MaterialApp(home: const PermissionDeniedScreen()),
  );
}

class Edi extends StatefulWidget {
  const Edi({super.key});

  @override
  State<Edi> createState() => _EdiState();
}

class _EdiState extends State<Edi> {
  @override
  void initState() {
    super.initState();
  }

  var obxLoginController = Get.put(LoginController());

  var loginController = Get.find<LoginController>();

  @override
  void dispose() {
    //_databaseInstance.close();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('es')],
      title: 'SOS EDI',
      theme: ThemeData(fontFamily: 'GTWalsheimPro', useMaterial3: false),
      initialRoute: '/',

      getPages: [
        GetPage(name: "/login", page: () => const LoginPage()),

        GetPage(name: "/dashboard", page: () => const Dashboard()),
      ],
      home: Obx(() {
        switch (obxLoginController.status) {
          case Status.Autenticado:
            return Dashboard();

          case Status.Iniciando:
            return const Splash();
          case Status.NoAutorizado:
            return const LoginPage();
          case Status.Autenticando:
            return const LoginPage();
          case Status.Loguear:
            return const LoginPage();
          default:
            return const ErrorPage();
        }
      }),
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Splash');
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: const Text('Ocurrio un error'));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class PermissionDeniedScreen extends StatelessWidget {
  const PermissionDeniedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Permisos de ubicación denegados. La app no puede funcionar correctamente.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
