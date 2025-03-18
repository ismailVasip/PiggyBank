import 'package:piggy_bank/core/error/exceptions.dart';
import 'package:piggy_bank/features/learning_process/data/models/word_pool_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class WordPoolRemoteDataSource{
  Future<WordPoolModel> uploadToWordPool(WordPoolModel wordPoolModel);
}
class WordPoolRemoteDataSourceImp implements WordPoolRemoteDataSource{
  final SupabaseClient supabaseClient;
  WordPoolRemoteDataSourceImp(this.supabaseClient);

  @override
  Future<WordPoolModel> uploadToWordPool(WordPoolModel wordPoolModel) async{
       try{
        //verileri vermek için map oluşturduk.
        //select olmazsa data - dynamic olur , olursa data - List<Map<String, dynamic>> olur
        final data = await supabaseClient.from('wordpool').insert(wordPoolModel.toJson()).select();

        return WordPoolModel.fromJson(data.first);

       }catch(e){
        throw ServerException(e.toString());
       }
    
  }

}