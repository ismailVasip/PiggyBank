import 'package:piggy_bank/core/error/exceptions.dart';
import 'package:piggy_bank/features/home/data/models/learning_process_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class CreateLearningProcessRemoteDateSource {
  Future<LearningProcessModel> createLearningProcess(
    LearningProcessModel learningProcessModel,
  );

  Future<List<LearningProcessModel>> getAllProcesses();

  Future<bool> deleteProcess(String processId);
}

class CreateLearningProcessRemoteDateSourceImp
    extends CreateLearningProcessRemoteDateSource {
  final SupabaseClient supabaseClient;
  CreateLearningProcessRemoteDateSourceImp(this.supabaseClient);

  @override
  Future<LearningProcessModel> createLearningProcess(
    LearningProcessModel learningProcessModel,
  ) async {
    try {
      final learningProcess =
          await supabaseClient
              .from('learningprocess')
              .insert(learningProcessModel.toJson())
              .select();

      return LearningProcessModel.fromJson(learningProcess.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<LearningProcessModel>> getAllProcesses() async {
    try {
      final allProcesses = await supabaseClient
          .from('learningprocess')
          .select('*')
          .order('updated_at', ascending: false);

      return allProcesses
          .map((process) => LearningProcessModel.fromJson(process))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> deleteProcess(String processId) async {
    try {
      final response = await supabaseClient
          .from('learningprocess')
          .delete()
          .eq('id', processId)
          .select('id');

      return response.isNotEmpty;
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
