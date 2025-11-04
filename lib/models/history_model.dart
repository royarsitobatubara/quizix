class HistoryModel {
  final int? id;
  final String lesson;
  final String level;
  final int point;

  const HistoryModel({
    this.id,
    required this.lesson,
    required this.level,
    required this.point,
  });

  Map<String, dynamic> toJson() {
    return {
      'lesson': lesson,
      'level': level,
      'point': point
    };
  }

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json['id'],
      lesson: json['lesson'],
      level: json['level'],
      point: json['point'],

    );
  }

}
