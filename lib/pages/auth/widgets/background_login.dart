import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:sos_edi/constantes.dart';

class BackgroundLogin extends StatefulWidget {
  final Widget? child;
  const BackgroundLogin({Key? key, @required this.child}) : super(key: key);

  @override
  State<BackgroundLogin> createState() => _BackgroundLoginState();
}

class _BackgroundLoginState extends State<BackgroundLogin>
    with SingleTickerProviderStateMixin {
  bool animacion = false;
  bool worker = false;
  bool worker_night = false;
  bool isNight = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 500), () {
      animacion = !animacion;
    });
    isNight = DateTime.now().hour >= 18;
  }

  void dispose() {
    super.dispose();
    animacion = false;
    worker = false;
    worker_night = false;
    isNight = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Container(
        height: size.height * 1,
        child: Stack(
          children: <Widget>[
            isNight
                ? Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: Image.asset(
                        "assets/images/login/noche1.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 18,
                      width: 150,
                      height: 50,
                      child: Image.asset(
                        "assets/images/tgestiona_logo_w.png",
                        color: Colors.white,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: 100,
                      left: 20,
                      height: 70,
                      child: AnimatedOpacity(
                        opacity: animacion ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 800),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bienvenido a EDI",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Líderes en Facility Management",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      top: 0,
                      left: 0,
                      bottom: animacion ? 0 : -2400,
                      right: 0,
                      onEnd: () {
                        setState(() {
                          worker_night = true;
                        });
                      },
                      duration: Duration(milliseconds: 800),
                      child: Image.asset(
                        "assets/images/login/noche2.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: Image.asset(
                        "assets/images/login/noche3.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    AnimatedPositioned(
                      top: 0,
                      left: worker_night ? 0 : -248,
                      bottom: 0,
                      right: 0,
                      child: Image.asset(
                        "assets/images/login/ingeniero_noche.png",
                        fit: BoxFit.fill,
                      ),
                      duration: Duration(milliseconds: 500),
                    ),
                    Positioned(
                      bottom: 75,
                      left: 110,
                      right: 110,
                      child: widget.child!,
                    ),
                  ],
                )
                : Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: Image.asset(
                        "assets/images/login/dia1.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 18,
                      width: 150,
                      height: 50,
                      child: Image.asset(
                        "assets/images/tgestiona_logo_w.png",
                        color: kprimaryColorDark,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: 100,
                      left: 20,
                      height: 70,
                      child: AnimatedOpacity(
                        opacity: animacion ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 800),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bienvenido a EDI",
                              style: TextStyle(
                                color: kprimaryColorDark,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Líderes en Facility Management",
                              style: TextStyle(
                                color: kprimaryColorDark,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      top: 0,
                      bottom: 0,
                      right: animacion ? 0 : -200,
                      child: Image.asset(
                        "assets/images/login/dia2.png",
                        fit: BoxFit.fill,
                      ),
                      duration: Duration(milliseconds: 500),
                    ),
                    AnimatedPositioned(
                      top: 0,
                      left: animacion ? 0 : -200,
                      bottom: 0,
                      right: 0,
                      child: Image.asset(
                        "assets/images/login/dia2(1).png",
                        fit: BoxFit.fill,
                      ),
                      duration: Duration(milliseconds: 500),
                    ),
                    AnimatedPositioned(
                      top: 0,
                      left: 0,
                      bottom: animacion ? 0 : -2400,
                      right: 0,
                      child: Image.asset(
                        "assets/images/login/dia3.png",
                        fit: BoxFit.fill,
                      ),
                      onEnd: () {
                        setState(() {
                          worker = !worker;
                        });
                      },
                      duration: Duration(milliseconds: 800),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: Image.asset(
                        "assets/images/login/dia4.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    AnimatedPositioned(
                      top: 0,
                      left: worker ? 0 : -225,
                      bottom: 0,
                      right: 0,
                      child: Image.asset(
                        "assets/images/login/ingeniero_dia.png",
                        fit: BoxFit.fill,
                      ),
                      duration: Duration(milliseconds: 500),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 110,
                      right: 110,
                      child: widget.child!,
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
