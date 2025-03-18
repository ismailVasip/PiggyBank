import 'package:piggy_bank/features/learning_process/domain/entities/word_pool.dart';

class WordPoolModel extends WordPool {
  WordPoolModel({
    required super.id,
    required super.word,
    required super.meaning,
    required super.type,
    required super.synonym,
    required super.sentence,
    required super.updatedAt,
  });

  
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'word': word,
      'meaning': meaning,
      'type': type,
      'synonym': synonym,
      'sentence': sentence,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory WordPoolModel.fromJson(Map<String, dynamic> map) {
    return WordPoolModel(
      id: map['id'] as String,
      word: map['word'] as String,
      meaning: map['meaning'] as String,
      type: map['type'] as String,
      synonym: map['synonym'] as String,
      sentence: map['sentence'] as String,
      updatedAt: map['updated_at'] == null ?
       DateTime.parse(map['updated_at'])
       :DateTime.now() ,
    );
  }
}
