import 'package:bottom_sheet/bottom_sheet.dart';

// import 'package:edi_updated/src/controller/inicio_controller.dart';
// import 'package:edi_updated/src/provider/login_provider.dart';
// import 'package:edi_updated/src/provider/resources_provider.dart';
// import 'package:edi_updated/src/widgets/login_inicio.dart';
import 'package:get/get.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sos_edi/constantes.dart';
import 'package:sos_edi/controller/login_controller.dart';
import 'package:sos_edi/environment.dart';
import 'package:sos_edi/pages/auth/widgets/background_login.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  bool isUseSafeArea = false;

  TextEditingController? _usr;
  TextEditingController? _psw;

  PackageInfo info = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  var obxLoginController = Get.put(LoginController());
  final loginController = Get.find<LoginController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  //  final LoadingButtonController _btnController1 = LoadingButtonController();
  late AnimationController animationController;
  final bool show = true;

  @override
  void initState() {
    super.initState();

    PackageInfo.fromPlatform().then((val) {
      setState(() {
        info = val;
      });
    });
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    if (kDebugMode) {
      _usr = TextEditingController(text: Enviroment.usr);
      _psw = TextEditingController(text: Enviroment.psw);
    } else {
      _usr = TextEditingController(text: "");
      _psw = TextEditingController(text: "");
    }
  }

  @override
  void dispose() {
    _usr?.dispose();
    _psw?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _key,
        body: BackgroundLogin(
          child: Column(
            children: [
              Container(
                height: 50,
                width: 225,
                margin: const EdgeInsets.only(bottom: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 66, 127, 226),
                      const Color.fromARGB(255, 10, 0, 95),
                    ],
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    showSheet();
                  },
                  child: Center(
                    child: Text(
                      "Acceder",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              //redes sociales
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      const url =
                          'https://www.linkedin.com/company/tgestionaperu/posts/?feedView=all'; // or add your URL here
                      Uri uri = Uri.parse(url);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      } else {
                        throw 'No se pudo iniciar $url';
                      }
                    },
                    child: Brand(Brands.linkedin),
                  ),
                  GestureDetector(
                    onTap: () async {
                      const url =
                          'https://www.youtube.com/@tgestionaPeru'; // or add your URL here
                      Uri uri = Uri.parse(url);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      } else {
                        throw 'No se pudo iniciar $url';
                      }
                    },
                    child: Brand(Brands.youtube),
                  ),
                  GestureDetector(
                    onTap: () async {
                      const url =
                          'https://www.tgestiona.com.pe/'; // or add your URL here
                      Uri uri = Uri.parse(url);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      } else {
                        throw 'No se pudo iniciar $url';
                      }
                    },
                    child: Brand(Brands.chrome),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  showSheet() async {
    var data1 = await showFlexibleBottomSheet<dynamic?>(
      minHeight: 0,
      initHeight: 0.65,
      maxHeight: 1,
      context: context,
      isSafeArea: isUseSafeArea,
      bottomSheetColor: const Color.fromARGB(0, 255, 255, 255),
      barrierColor: const Color.fromARGB(0, 0, 0, 0),
      builder: (context, controller, offset) {
        // late LoginProvider loginProvider = Provider.of<LoginProvider>(
        //   context,
        //   listen: true,
        // );

        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 30.0,
                  right: 30.0,
                  top: 10,
                  bottom: 30,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        children: <Widget>[
                          const Image(
                            image: AssetImage(
                              'assets/images/tgestiona_logo_w.png',
                            ),
                            height: 50,
                          ),
                          const SizedBox(height: 8),
                          Column(
                            children: [
                              Text(
                                "${info.version}",

                                ///${info.buildNumber}
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF2C699B),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 30.0,
                              right: 30.0,
                              bottom: 8.0,
                              top: 8.0,
                            ),
                            child: TextFormField(
                              onChanged: (value) =>
                                  loginController.guardarUsr(value),
                              controller: _usr,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ingrese una usuario';
                                }
                                return null;
                              },
                              obscureText: false,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Color(0xFF156185),
                                ),
                                labelText: 'Usuario',
                                labelStyle: TextStyle(color: Color(0xFF156185)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF156185),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 30.0,
                              right: 30.0,
                              bottom: 8.0,
                              top: 8.0,
                            ),
                            child: Obx(
                              () => TextFormField(
                                onChanged: (value) =>
                                    loginController.guardarPsw(value),
                                controller: _psw,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Ingrese una contraseña';
                                  }
                                  return null;
                                },
                                obscureText: loginController.ocultarClave,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Color(0xFF156185),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      obxLoginController.ocultarClave
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: const Color(0xFF156185),
                                    ),
                                    onPressed: () {
                                      loginController.setOcultarClave(
                                        !loginController.ocultarClave,
                                      );
                                    },
                                  ),
                                  labelText: 'Clave',
                                  labelStyle: const TextStyle(
                                    color: Color(0xFF156185),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF156185),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            var response = await Navigator.pushNamed(
                              context,
                              '/recuperar_clave',
                            );
                            if (response != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(response.toString())),
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: const Text(
                              'Recuperar Contraseña',
                              style: TextStyle(color: kPrimaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    ArgonButton(
                      height: 100,
                      width: 250,
                      onTap: (startLoading, stopLoading, btnState) async {
                        if (_formKey.currentState!.validate()) {
                          startLoading();

                          FocusScope.of(context).unfocus();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Validando datos...")),
                          );

                          dynamic res = await loginController.ingresarLogin(
                            _usr?.text,
                            _psw?.text,
                          );

                          if (res['estado'] == 1) {
                            stopLoading();
                            await Future.delayed(
                              const Duration(milliseconds: 200),
                            );

                            return Navigator.pop(context, true);
                          } else {
                            stopLoading();
                            await Future.delayed(
                              const Duration(milliseconds: 500),
                            );
                            stopLoading();
                            return Navigator.pop(context, res['msg']);
                          }
                        } else {
                          stopLoading();
                          await Future.delayed(
                            const Duration(milliseconds: 200),
                          );

                          return Navigator.pop(context, false);
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 225,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              /*  rrgba(0,127,208,255)) */
                              const Color.fromARGB(255, 115, 201, 238),
                              const Color.fromARGB(255, 0, 125, 206),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "INGRESAR",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      anchors: [0, 0.5, 1],
    );

    await Future.delayed(const Duration(milliseconds: 300));
    if (data1 == true) {
      loginController.setAutenticado();
    }
    if (data1 == false) {
      loginController.setLoguear();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("revise la informacion...")));
    }
    if (data1 is String) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(data1!)));
    }
  }
}

/**
 


 */
