class Pokemon {
  final int id;

  String name;

  int? height;

  int? weight;

  String? photoUrl;

  Map<String, int>? stats;

  String? color;

  List<String>? types;

  Pokemon({
    required this.id,
    required this.name,
    this.height,
    this.weight,
    this.photoUrl,
    this.stats,
    this.color,
    this.types,
  });
}
