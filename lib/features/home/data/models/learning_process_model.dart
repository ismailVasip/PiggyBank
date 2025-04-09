import 'package:piggy_bank/features/home/domain/entities/learning_process.dart';

class LearningProcessModel extends LearningProcess {
  LearningProcessModel({
    required super.id,
    required super.title,
    required super.updatedAt,
  });

  
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory LearningProcessModel.fromJson(Map<String, dynamic> map) {
    return LearningProcessModel(
      id: map['id'] as String,
      title: map['title'] as String,
      updatedAt: map['updated_at'] == null ?
       DateTime.parse(map['updated_at'])
       :DateTime.now() ,
    );
  }
}
