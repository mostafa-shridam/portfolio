class Course {
  String? id;
  String? title;
  String? description;
  String? instructor;
  String? platform;
  String? certificateUrl;
  String? completedDate;
  List<String>? skills;
  double? rating;
  String? iconName; // FontAwesome icon identifier

  Course({
    this.id,
    this.title,
    this.description,
    this.instructor,
    this.platform,
    this.certificateUrl,
    this.completedDate,
    this.skills,
    this.rating,
    this.iconName,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      instructor: json['instructor'],
      platform: json['platform'],
      certificateUrl: json['certificate_url'],
      completedDate: json['completed_date'],
      skills: json['skills'] != null ? List<String>.from(json['skills']) : null,
      rating: json['rating']?.toDouble(),
      iconName: json['icon_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'instructor': instructor,
      'platform': platform,
      'certificate_url': certificateUrl,
      'completed_date': completedDate,
      'skills': skills,
      'rating': rating,
      'icon_name': iconName,
    };
  }
}
