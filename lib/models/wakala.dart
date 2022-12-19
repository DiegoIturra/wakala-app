class Wakala{
  final int id;
  final String sector;
  final String autor;
  final String fecha;

  const Wakala({
    required this.id,
    required this.sector,
    required this.autor,
    required this.fecha
  });

  factory Wakala.fromJson(Map<String, dynamic> json) {
    return Wakala(
      id: json['id'],
      sector: json['sector'],
      autor: json['autor'],
      fecha: json['fecha']
    );
  }
}