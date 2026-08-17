import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static String get filename {
    if (kReleaseMode) {
      return ".env.prd";
    }
    return ".env.dev";
  }

  static String get usr {
    return dotenv.env['USR'] ?? 'No esta configurado el usuario';
  }

  static String get psw {
    return dotenv.env['PSW'] ?? 'No esta configurado la clave';
  }

  static String get apiUrlSeguridad {
    return dotenv.env['API_URL_SEGURIDAD'] ??
        'No esta configurado el API_URL_LAPI_URL_SEGURIDADOCKER';
  }

  static String get apiUrlSOS {
    return dotenv.env['API_URL_SOS'] ?? 'No esta configurado el API_URL_SOS';
  }

  static String get onesignalAppId {
    return dotenv.env['ONESIGNAL_APP_ID'] ?? '';
  }

  //API_PAGE_EDI
}
