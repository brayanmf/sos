class TipoAlerta {
  final int id;
  final String nombre;

  TipoAlerta({required this.id, required this.nombre});

  factory TipoAlerta.fromJson(Map<String, dynamic> json) {
    return TipoAlerta(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
    );
  }
}