class Project {
  String? id;
  String? title;
  String? description;
  String? image;
  List<String>? images;
  String? githubUrl;
  String? googlePlayUrl;
  String? appStoreUrl;
  List<String>? technologies;
  String? startDate;
  String? endDate;
  bool? isFeatured;
  bool? hasGradient;

  Project({
    this.id,
    this.title,
    this.description,
    this.image,
    this.images,
    this.githubUrl,
    this.googlePlayUrl,
    this.appStoreUrl,
    this.technologies,
    this.startDate,
    this.endDate,
    this.isFeatured,
    this.hasGradient,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      githubUrl: json['github_url'],
      googlePlayUrl: json['google_play_url'],
      appStoreUrl: json['app_store_url'],
      technologies: json['technologies'] != null
          ? List<String>.from(json['technologies'])
          : null,
      startDate: json['start_date'],
      endDate: json['end_date'],
      isFeatured: json['is_featured'],
      hasGradient: json['has_gradient'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'images': images,
      'github_url': githubUrl,
      'google_play_url': googlePlayUrl,
      'app_store_url': appStoreUrl,
      'technologies': technologies,
      'start_date': startDate,
      'end_date': endDate,
      'is_featured': isFeatured,
      'has_gradient': hasGradient,
    };
  }
}
