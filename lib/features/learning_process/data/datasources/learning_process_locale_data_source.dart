import 'package:hive/hive.dart';
import 'package:piggy_bank/features/learning_process/data/models/word_pool_model.dart';

abstract interface class LearningProcessLocaleDataSource {
  void uploadLocaleWordPool({required List<WordPoolModel> list});
  void uploadLocalePiggyBank({required List<WordPoolModel> list});

  List<WordPoolModel> loadLocaleWordPool();
  List<WordPoolModel> loadLocalePiggyBank();

  (String?, int) loadPiggyBankSummary();
  (String?, int) loadWordPoolSummary();
}

class LearningProcessLocaleDataSourceImp
    implements LearningProcessLocaleDataSource {
  final Box piggyBankBox;
  final Box wordPoolBox;

  LearningProcessLocaleDataSourceImp(this.piggyBankBox, this.wordPoolBox);

  @override
  List<WordPoolModel> loadLocalePiggyBank() {
    List<WordPoolModel> list = [];

    piggyBankBox.read(() {
      for (int i = 0; i < piggyBankBox.length; i++) {
        list.add(WordPoolModel.fromJson(piggyBankBox.get(i.toString())));
      }
    });

    return list;
  }

  @override
  List<WordPoolModel> loadLocaleWordPool() {
    List<WordPoolModel> list = [];

    wordPoolBox.read(() {
      for (int i = 0; i < wordPoolBox.length; i++) {
        list.add(WordPoolModel.fromJson(wordPoolBox.get(i.toString())));
      }
    });

    return list;
  }

  @override
  void uploadLocalePiggyBank({required List<WordPoolModel> list}) {
    piggyBankBox.clear();
    piggyBankBox.write(() {
      for (int i = 0; i < list.length; i++) {
        piggyBankBox.put(i.toString(), list[i].toJson());
      }
    });
  }

  @override
  void uploadLocaleWordPool({required List<WordPoolModel> list}) {
    wordPoolBox.clear();
    wordPoolBox.write(() {
      for (int i = 0; i < list.length; i++) {
        wordPoolBox.put(i.toString(), list[i].toJson());
      }
    });
  }

  @override
  (String?, int) loadPiggyBankSummary() {
    if (piggyBankBox.isEmpty) {
      return (null, 0);
    }

    return (piggyBankBox.getAt(piggyBankBox.length - 1), piggyBankBox.length);
  }

  @override
  (String?, int) loadWordPoolSummary() {
    if (wordPoolBox.isEmpty) {
      return (null, 0);
    }

    return (wordPoolBox.getAt(wordPoolBox.length - 1), wordPoolBox.length);
  }
}
