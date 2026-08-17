import 'package:sos_edi/client/dio.dart';
import 'package:sos_edi/models/sos/alerta_evacuacion_model.dart';
import 'package:sos_edi/models/sos/confirmacion_seguridad_model.dart';

class EmergencyService {
  Future<AlertaEvacuacionModel?> getLatestAlert() async {
    try {
      var res = await dioSOS.get("/api/Emergency/latest-alert");
      if (res.data != null) {
        return AlertaEvacuacionModel.fromJson(res.data);
      }
      return null;
    } catch (e) {
      print('Error al obtener alerta: $e');
      return null;
    }
  }

  Future<bool> activateAlert(AlertaEvacuacionModel data) async {
    try {
      var res = await dioSOS.post(
        "/api/Emergency/activate",
        data: data.toJson(),
      );
      return res.statusCode == 200 || res.statusCode == 201;
    } catch (e) {
      print('Error al activar alerta: $e');
      return false;
    }
  }

  Future<bool> confirmSafety(ConfirmacionSeguridadModel data) async {
    try {
      var res = await dioSOS.post(
        "/api/Emergency/confirm-safety",
        data: data.toJson(),
      );
      return res.statusCode == 200 || res.statusCode == 201;
    } catch (e) {
      print('Error al confirmar seguridad: $e');
      return false;
    }
  }
}
