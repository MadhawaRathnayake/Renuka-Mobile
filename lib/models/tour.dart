class Tour {
  final String id;
  final String title;
  final List<String> destinations;
  final int days;
  final String photo;
  final String desc;

  Tour({
    required this.id,
    required this.title,
    required this.destinations,
    required this.days,
    required this.photo,
    required this.desc,
  });

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
      id: json['_id'],
      title: json['title'],
      destinations: List<String>.from(json['destinations']),
      days: json['days'],
      photo: json['photo'],
      desc: json['desc'],
    );
  }
}
