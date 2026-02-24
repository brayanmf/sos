import 'package:dio/dio.dart';
import 'package:sos_edi/environment.dart';

final dioSeguridad =
    Dio()
      ..options = BaseOptions(
        baseUrl: Enviroment.apiUrlSeguridad,
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
      );
