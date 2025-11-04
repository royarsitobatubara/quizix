class DetailHistoryModel {
  final int? id;
  final int historyId;
  final String question;
  final String answer;
  final int isCorrect;

  const DetailHistoryModel({
    this.id,
    required this.historyId,
    required this.question,
    required this.answer,
    required this.isCorrect,
  });

  Map<String, dynamic> toJson() {
    return {
      'history_id': historyId,
      'question': question,
      'answer': answer,
      'is_correct': isCorrect
    };
  }

  factory DetailHistoryModel.fromJson(Map<String, dynamic> json){
    return DetailHistoryModel(
      id: json['id'],
      historyId: json['history_id'],
      question: json['question'],
      answer: json['answer'],
      isCorrect: json['is_correct']
    );
  }

}