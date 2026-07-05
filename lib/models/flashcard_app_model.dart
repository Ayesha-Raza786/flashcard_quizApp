class Flashcard {
  int? id;
  String question;
  String answer;
  String tag;


  Flashcard({
    this.id,
    required this.question,
    required this.answer,
    required this.tag,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'tag': tag,
    };
  }

  factory Flashcard.fromMap(Map<String, dynamic> map) {
    return Flashcard(
      id: map['id'],
      question: map['question'],
      answer: map['answer'],
      tag: map['tag'],
    );
  }
}