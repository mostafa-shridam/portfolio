class Skill {
  String? id;
  String? name;
  String? iconName; // e.g., FontAwesome icon identifier
  String? image;
  double? proficiency;

  Skill({this.id, this.name, this.iconName, this.image, this.proficiency});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'],
      name: json['name'],
      iconName: json['iconName'],
      image: json['image'],
      proficiency: json['proficiency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iconName': iconName,
      'image': image,
      'proficiency': proficiency,
    };
  }
}
