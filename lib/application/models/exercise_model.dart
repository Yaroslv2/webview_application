class ExersiceModel {
  final String name;
  final String description;
  final String performing;
  final String imageUrl;
  final List<String> muscleGroups;

  ExersiceModel({
    required this.name,
    required this.description,
    required this.performing,
    required this.imageUrl,
    required this.muscleGroups,
  });

  factory ExersiceModel.fromJson(Map<String, dynamic> json) => ExersiceModel(
        name: json["name"],
        description: json["description"],
        performing: json["performing"],
        imageUrl: json["imageUrl"],
        muscleGroups: List<String>.from(json["muscleGroups"]),
      );
}
