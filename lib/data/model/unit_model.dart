class Unit {
  final int id;
  final String uuid;
  final String name;

  Unit({
    required this.id,
    required this.uuid,
    required this.name,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json["id"],
        uuid: json["uuid"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "name": name,
      };
}
