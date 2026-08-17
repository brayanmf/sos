import 'dart:convert';

ConfirmacionSeguridadModel confirmacionSeguridadModelFromJson(String str) =>
    ConfirmacionSeguridadModel.fromJson(json.decode(str));

String confirmacionSeguridadModelToJson(ConfirmacionSeguridadModel data) =>
    json.encode(data.toJson());

class ConfirmacionSeguridadModel {
  int? idUsuario;
  int? alertaEvacuacionId;
  double? latitud;
  double? longitud;
  String? estadoReportado;
  String? comentario;

  ConfirmacionSeguridadModel({
    this.idUsuario,
    this.alertaEvacuacionId,
    this.latitud,
    this.longitud,
    this.estadoReportado,
    this.comentario,
  });

  factory ConfirmacionSeguridadModel.fromJson(Map<String, dynamic> json) =>
      ConfirmacionSeguridadModel(
        idUsuario: json["idUsuario"],
        alertaEvacuacionId: json["alertaEvacuacionId"],
        latitud: (json["latitud"] as num?)?.toDouble(),
        longitud: (json["longitud"] as num?)?.toDouble(),
        estadoReportado: json["estadoReportado"],
        comentario: json["comentario"],
      );

  Map<String, dynamic> toJson() => {
    "idUsuario": idUsuario,
    "alertaEvacuacionId": alertaEvacuacionId,
    "latitud": latitud,
    "longitud": longitud,
    "estadoReportado": estadoReportado,
    "comentario": comentario,
  };
}
