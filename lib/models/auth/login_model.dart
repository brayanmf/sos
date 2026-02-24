// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? token;
  String? tokenApp;
  String? nombre;
  String? nombreCompleto;
  int? id;
  int? expiresIn;
  String? role;
  dynamic dominioweb;
  bool? esInterno;
  List<Ubicacion>? ubicacion;
  List<Datos>? datos;
  List<ListOpcione>? listOpciones;
  int? tipoResultado;
  String? mensaje;
  String? arrImgUsuario;
  String? arrImgFirma;
  String? arrImgCliente;

  LoginModel({
    this.token,
    this.tokenApp,
    this.nombre,
    this.nombreCompleto,
    this.id,
    this.expiresIn,
    this.role,
    this.dominioweb,
    this.esInterno,
    this.ubicacion,
    this.datos,
    this.listOpciones,
    this.tipoResultado,
    this.mensaje,
    this.arrImgUsuario,
    this.arrImgFirma,
    this.arrImgCliente,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    arrImgUsuario: json["ArrImgUsuario"],
    arrImgFirma: json["ArrImgFirma"],
    arrImgCliente: json["ArrImgCliente"],
    token: json["token"],
    tokenApp: json["tokenApp"],
    nombre: json["Nombre"],
    nombreCompleto: json["NombreCompleto"],
    id: json["Id"],
    expiresIn: json["expiresIn"],
    role: json["role"],
    dominioweb: json["dominioweb"],
    esInterno: json["esInterno"],
    ubicacion:
        json["Ubicacion"] == null
            ? []
            : List<Ubicacion>.from(
              json["Ubicacion"]!.map((x) => Ubicacion.fromJson(x)),
            ),
    datos:
        json["Datos"] == null
            ? []
            : List<Datos>.from(json["Datos"]!.map((x) => Datos.fromJson(x))),
    listOpciones:
        json["listOpciones"] == null
            ? []
            : List<ListOpcione>.from(
              json["listOpciones"]!.map((x) => ListOpcione.fromJson(x)),
            ),
    tipoResultado: json["TipoResultado"],
    mensaje: json["Mensaje"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "tokenApp": tokenApp,
    "Nombre": nombre,
    "NombreCompleto": nombreCompleto,
    "Id": id,
    "expiresIn": expiresIn,
    "role": role,
    "dominioweb": dominioweb,
    "esInterno": esInterno,
    "Ubicacion":
        ubicacion == null
            ? []
            : List<dynamic>.from(ubicacion!.map((x) => x.toJson())),
    "Datos":
        datos == null ? [] : List<dynamic>.from(datos!.map((x) => x.toJson())),
    "listOpciones":
        listOpciones == null
            ? []
            : List<dynamic>.from(listOpciones!.map((x) => x.toJson())),
    "TipoResultado": tipoResultado,
    "Mensaje": mensaje,
  };
}

class Datos {
  String? login;
  String? email;
  String? celular;
  String? telefono;
  String? roles;
  bool? tieneFirmaElectronica;
  bool? flagconfiguracionpersona;
  bool? flagproveedor;

  Datos({
    this.login,
    this.email,
    this.celular,
    this.telefono,
    this.roles,
    this.tieneFirmaElectronica,
    this.flagconfiguracionpersona,
    this.flagproveedor,
  });

  factory Datos.fromJson(Map<String, dynamic> json) => Datos(
    login: json["Login"],
    email: json["Email"],
    celular: json["Celular"],
    telefono: json["Telefono"],
    roles: json["Roles"],
    tieneFirmaElectronica: json["TieneFirmaElectronica"],
    flagconfiguracionpersona: json["Flagconfiguracionpersona"],
    flagproveedor: json["Flagproveedor"],
  );

  Map<String, dynamic> toJson() => {
    "Login": login,
    "Email": email,
    "Celular": celular,
    "Telefono": telefono,
    "Roles": roles,
    "TieneFirmaElectronica": tieneFirmaElectronica,
    "Flagconfiguracionpersona": flagconfiguracionpersona,
    "Flagproveedor": flagproveedor,
  };
}

class ListOpcione {
  int? id;
  dynamic parentId;
  String? path;
  String? title;
  String? type;
  String? icontype;
  dynamic collapse;
  dynamic ab;
  List<dynamic>? children;
  List<dynamic>? listAcciones;

  ListOpcione({
    this.id,
    this.parentId,
    this.path,
    this.title,
    this.type,
    this.icontype,
    this.collapse,
    this.ab,
    this.children,
    this.listAcciones,
  });

  factory ListOpcione.fromJson(Map<String, dynamic> json) => ListOpcione(
    id: json["id"],
    parentId: json["parentId"],
    path: json["path"],
    title: json["title"],
    type: json["type"],
    icontype: json["icontype"],
    collapse: json["collapse"],
    ab: json["ab"],
    children:
        json["children"] == null
            ? []
            : List<dynamic>.from(json["children"]!.map((x) => x)),
    listAcciones:
        json["listAcciones"] == null
            ? []
            : List<dynamic>.from(json["listAcciones"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parentId": parentId,
    "path": path,
    "title": title,
    "type": type,
    "icontype": icontype,
    "collapse": collapse,
    "ab": ab,
    "children":
        children == null ? [] : List<dynamic>.from(children!.map((x) => x)),
    "listAcciones":
        listAcciones == null
            ? []
            : List<dynamic>.from(listAcciones!.map((x) => x)),
  };
}

class Ubicacion {
  int? idCliente;
  int? idInmueble;
  String? inmueble;
  int? idEdificio;
  String? edificio;
  int? idNivel;
  String? nivel;
  String? centroCosto;
  String? descripcion;

  Ubicacion({
    this.idCliente,
    this.idInmueble,
    this.inmueble,
    this.idEdificio,
    this.edificio,
    this.idNivel,
    this.nivel,
    this.centroCosto,
    this.descripcion,
  });

  factory Ubicacion.fromJson(Map<String, dynamic> json) => Ubicacion(
    idCliente: json["IdCliente"],
    idInmueble: json["IdInmueble"],
    inmueble: json["Inmueble"],
    idEdificio: json["IdEdificio"],
    edificio: json["Edificio"],
    idNivel: json["IdNivel"],
    nivel: json["Nivel"],
    centroCosto: json["CentroCosto"],
    descripcion: json["Descripcion"],
  );

  Map<String, dynamic> toJson() => {
    "IdCliente": idCliente,
    "IdInmueble": idInmueble,
    "Inmueble": inmueble,
    "IdEdificio": idEdificio,
    "Edificio": edificio,
    "IdNivel": idNivel,
    "Nivel": nivel,
    "CentroCosto": centroCosto,
    "Descripcion": descripcion,
  };
}
