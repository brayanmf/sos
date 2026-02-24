import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static String get filename {
    if (kReleaseMode) {
      return ".env.prd";
    }
    return ".env.dev";
  }

  static String get apiUrlAdministracion {
    return dotenv.env['API_URL_ADMINISTRACION'] ??
        'API_URL_ADMINISTRACION no se encuentra';
  }

  static String get apiUrl {
    return dotenv.env['API_URL'] ?? 'API_URL no se encuentra';
  }

  static String get apiUrlParking {
    return dotenv.env['API_URL_PARKING'] ?? 'API_URL no se encuentra';
  }

  static String get usr {
    return dotenv.env['USR'] ?? 'No esta configurado el usuario';
  }

  static String get psw {
    return dotenv.env['PSW'] ?? 'No esta configurado la clave';
  }

  static String get apiTuya {
    return dotenv.env['API_TUYA'] ?? 'No esta configurado la clave';
  }

  static String get apiImageTuya {
    return dotenv.env['API_IMAGE_TUYA'] ?? 'No esta configurado la clave';
  }

  static String get azureAccountName {
    return dotenv.env['AZURE_ACCOUNT_NAME'] ??
        'No esta configurado el nombre de la cuenta';
  }

  static String get azureContainerName {
    return dotenv.env['AZURE_CONTAINER_NAME'] ??
        'No esta configurado el nombre del contenedor';
  }

  static String get azureSas {
    return dotenv.env['AZURE_SAS'] ?? 'No esta configurado el sas';
  }

  static String get conecctionString {
    return dotenv.env['CONECCION_STRING'] ??
        'No esta configurado el coneccion_string';
  }

  static String get reactAppEnpointAzureLink {
    return dotenv.env['REACT_APP_ENPOINT_AZURE_LINK'] ??
        'No esta configurado el sas';
  }

  static String get apiNetTuya {
    return dotenv.env['API_NET_TUYA'] ?? 'No esta configurado el net_tuya';
  }

  static String get apiWebee {
    return dotenv.env['API_WEBEE'] ?? 'No esta configurado el api_webee';
  }

  static String get azureContainerNameEdi {
    return dotenv.env['AZURE_CONTAINER_NAME_EDI'] ??
        'No esta configurado el container edi';
  }

  static String get azureSasEdi {
    return dotenv.env['AZURE_SAS_EDI'] ?? 'No esta configurado el sas edi';
  }

  static String get apiWeather {
    return dotenv.env['API_WEATHER'] ?? 'No esta configurado el api_weather';
  }

  static String get keyWeather {
    return dotenv.env['KEY_WEATHER'] ?? 'No esta configurado el key_weather';
  }

  static String get apiUrlInspecciones {
    return dotenv.env['API_URL_INSPECCIONES'] ??
        'No esta configurado el api_url_inspecciones';
  }

  static String get azureContainerNameInspecciones {
    return dotenv.env['AZURE_CONTAINER_NAME_INSPECCION'] ??
        'No esta configurado el container inspecciones';
  }

  static String get azureSasInspecciones {
    return dotenv.env['AZURE_SAS_INSPECCION'] ??
        'No esta configurado el container inspecciones';
  }

  static String get connectionInspeccion {
    return dotenv.env['CONNECTION_INSPECCION'] ??
        'No esta configurado el api_url_inspecciones';
  }

  static String get connectionSolicitud {
    return dotenv.env['CONNECTION_SOLICITUD'] ??
        'No esta configurado el CONNECTION_SOLICITUD';
  }

  static String get azureContainerSolicitud {
    return dotenv.env['AZURE_CONTAINER_SOLICITUD'] ??
        'No esta configurado el   AZURE_CONTAINER_SOLICITUD';
  }

  static String get apiUrlInmueble {
    return dotenv.env['API_URL_INMUEBLE'] ??
        'No esta configurado el API_URL_INMUEBLE';
  }

  static String get connectionGestion {
    return dotenv.env['CONNECTION_GESTION'] ??
        'No esta configurado el CONNECTION_GESTION';
  }

  static String get azureContainerGestion {
    return dotenv.env['AZURE_CONTAINER_GESTION'] ??
        'No esta configurado el   AZURE_CONTAINER_GESTION';
  }

  static String get apiUrlLocker {
    return dotenv.env['API_URL_LOCKER'] ??
        'No esta configurado el API_URL_LOCKER';
  }

  static String get apiUrlSeguridad {
    return dotenv.env['API_URL_SEGURIDAD'] ??
        'No esta configurado el API_URL_LAPI_URL_SEGURIDADOCKER';
  }

  static String get apiUrlInspecciones2 {
    return dotenv.env['API_URL_INSPECCIONES2'] ??
        'No esta configurado el API_URL_INSPECCIONES2';
  }

  static String get apiUrlEquipo {
    return dotenv.env['API_URL_EQUIPO'] ?? 'No esta configurado el ORIGIN_URL';
  }

  static String get apiPageEdi {
    return dotenv.env['API_PAGE_EDI'] ?? 'No esta configurado el API_PAGE_EDI';
  }

  //API_PAGE_EDI
}
