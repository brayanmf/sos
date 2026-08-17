import 'dart:convert';

AlertaEvacuacionModel alertaEvacuacionModelFromJson(String str) =>
    AlertaEvacuacionModel.fromJson(json.decode(str));

String alertaEvacuacionModelToJson(AlertaEvacuacionModel data) =>
    json.encode(data.toJson());

class AlertaEvacuacionModel {
  int? id;
  String? idUsuario;
  String? tipoAlerta;
  String? mensajeAlerta;
  double? latitudActivacion;
  double? longitudActivacion;
  String? descripcionUbicacionActivacion;
  String? fechaActivacion;
  bool? activa;

  AlertaEvacuacionModel({
    this.id,
    this.idUsuario,
    this.tipoAlerta,
    this.mensajeAlerta,
    this.latitudActivacion,
    this.longitudActivacion,
    this.descripcionUbicacionActivacion,
    this.fechaActivacion,
    this.activa,
  });

  factory AlertaEvacuacionModel.fromJson(Map<String, dynamic> json) =>
      AlertaEvacuacionModel(
        id: json["id"],
        idUsuario: json["idUsuario"],
        tipoAlerta: json["tipoAlerta"],
        mensajeAlerta: json["mensajeAlerta"],
        latitudActivacion: (json["latitudActivacion"] as num?)?.toDouble(),
        longitudActivacion: (json["longitudActivacion"] as num?)?.toDouble(),
        descripcionUbicacionActivacion:
            json["descripcionUbicacionActivacion"],
        fechaActivacion: json["fechaActivacion"],
        activa: json["activa"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "idUsuario": idUsuario,
    "tipoAlerta": tipoAlerta,
    "mensajeAlerta": mensajeAlerta,
    "latitudActivacion": latitudActivacion,
    "longitudActivacion": longitudActivacion,
    "descripcionUbicacionActivacion": descripcionUbicacionActivacion,
    "fechaActivacion": fechaActivacion,
    "activa": activa,
  };
}
