import 'package:piggy_bank/core/error/exceptions.dart';
import 'package:piggy_bank/features/learning_process/data/models/learning_process_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class CreateLearningProcessRemoteDateSource {
  Future<LearningProcessModel> createLearningProcess(LearningProcessModel learningProcessModel);
}

class CreateLearningProcessRemoteDateSourceImp extends CreateLearningProcessRemoteDateSource{
   final SupabaseClient supabaseClient;
   CreateLearningProcessRemoteDateSourceImp(this.supabaseClient);
   
  @override
  Future<LearningProcessModel> createLearningProcess(LearningProcessModel learningProcessModel) async{
      try{
        final learningProcess = await supabaseClient.from('learningprocess').insert(learningProcessModel.toJson()).select();

        return LearningProcessModel.fromJson(learningProcess.first);
        
      }catch(e){
        throw ServerException(e.toString());
      }
  }
}