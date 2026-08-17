import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_edi/client/dio.dart';
import 'package:sos_edi/models/auth/login_model.dart';
import 'package:sos_edi/service/notification_service.dart';

enum Status {
  Iniciando,
  Autenticando,
  Autenticado,
  Loguear,
  NoAutorizado,
  Reserve,
  White,
}

class LoginController extends GetxController {
  final Rx<LoginModel?> _appUsr = Rx<LoginModel?>(null);

  LoginModel? get appUsr => _appUsr.value;
  set appUsr(LoginModel? value) => _appUsr.value = value;

  final Rx<bool> _autenticado = false.obs;

  bool get autenticado => _autenticado.value;

  set autenticado(bool value) => _autenticado.value = value;

  final Rx<bool> _ocultarClave = false.obs;

  bool get ocultarClave => _ocultarClave.value;

  set ocultarClave(bool value) => _ocultarClave.value = value;

  final Rx<Status> _status = Status.Autenticando.obs;

  Status get status => _status.value;

  set status(Status value) => _status.value = value;

  final Rx<String> _usr = "".obs;

  String get usr => _usr.value;

  set usr(String value) => _usr.value = value;

  final Rx<String> _psw = "".obs;

  String get psw => _psw.value;

  set psw(String value) => _psw.value = value;

  void guardarUsr(String usr) {
    _usr.value = usr;
  }

  void guardarPsw(String psw) {
    _psw.value = psw;
  }

  setOcultarClave(bool ocultarClave) {
    _ocultarClave.value = ocultarClave;
  }

  void setAutenticado() {
    _status.value = Status.Autenticado;
  }

  void setLoguear() {
    _status.value = Status.Loguear;
  }

  Future<void> cerrarSesion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    NotificationService().logout();
    appUsr = null;
    _status.value = Status.NoAutorizado;
  }

  Future<Map<String, dynamic>> ingresarLogin(String? usr, String? psw) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var dataRequest = {
        "login": usr,
        "password": psw,
        "codigoAcceso": "QU09TX0VES==",
        "version": 3,
      };

      var res = await dioSeguridad.post("/Authorize", data: dataRequest);

      final login = LoginModel.fromJson(res.data);

      if (login.tipoResultado == 1) {
        //validar que es otro usuario
        var json = prefs.getString('json');
        if (json != null) {
          var data = jsonDecode(json);
          if (data['usr'] != usr) {
            prefs.setBool('huella', false);
          }
        }

        await prefs.setString('token', login.tokenApp!);

        String encodedString = base64.encode(utf8.encode(psw!));

        await prefs.setString(
          'json',
          jsonEncode({'usr': usr, 'psw': encodedString, 'id': login.id}),
        );
        appUsr = login;
        NotificationService().login(login.id.toString());

        return {'estado': login.tipoResultado, 'msg': login.mensaje};
      } else if (login.tipoResultado == 2) {
        return {'estado': login.tipoResultado, 'msg': login.mensaje};
      } else {
        return {
          'estado': 3,
          'msg': 'Fuera de linea. Intentelo en unas horas...',
        };
      }
    } catch (e) {
      print(e);
      return {'estado': 4, 'msg': 'Ocurrio un error!'};
    }
  }
}
