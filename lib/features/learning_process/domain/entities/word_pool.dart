 
class WordPool {
  final String id;
  final String word;
  final String meaning;
  final String type;
  final String synonym;
  final String sentence;
  final DateTime updatedAt;
  final String learningProccessId;
  final bool isItLearned;

  WordPool({
    required this.id,
    required this.word,
    required this.meaning,
    required this.type,
    required this.synonym,
    required this.sentence,
    required this.updatedAt,
    required this.learningProccessId,
    required this.isItLearned
  });

  

}
