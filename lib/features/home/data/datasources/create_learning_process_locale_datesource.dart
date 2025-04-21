import 'package:hive/hive.dart';
import 'package:piggy_bank/features/home/data/models/learning_process_model.dart';

abstract interface class HomeLocalDataSource {
  void uploadLocalLProcesses({required List<LearningProcessModel> processes});
  List<LearningProcessModel> loadLocalLProcesses();
}

class HomeLocalDataSourceImp implements HomeLocalDataSource {
  final Box box;

  HomeLocalDataSourceImp(this.box);
  @override
  List<LearningProcessModel> loadLocalLProcesses() {
    List<LearningProcessModel> processes = [];

    box.read(() {
      for (int i = 0; i < box.length; i++) {
        processes.add(LearningProcessModel.fromJson(box.get(i.toString())));
      }
    });

    return processes;
  }

  @override
  void uploadLocalLProcesses({required List<LearningProcessModel> processes}) {
    box.clear(); // clear existing data before writing new ones

    box.write(() {
      for (int i = 0; i < processes.length; i++) {
        box.put(i.toString(), processes[i].toJson());
      }
    });
  }
}
