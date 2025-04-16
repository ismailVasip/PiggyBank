import 'package:piggy_bank/core/error/exceptions.dart';
import 'package:piggy_bank/features/learning_process/data/models/word_pool_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class WordPoolRemoteDataSource {
  Future<WordPoolModel> uploadToWordPool(WordPoolModel wordPoolModel);
  Future<List<WordPoolModel>> fetchAllWords(String id, bool isItLearned);
  Future<(String?, int)> fetchLearningProcessSummary(
    String processId,
    bool isItLearned,
  );
  Future<bool> removeWord(String id);
  Future<bool> addToPiggyBank(String id);
}

class WordPoolRemoteDataSourceImp implements WordPoolRemoteDataSource {
  final SupabaseClient supabaseClient;
  WordPoolRemoteDataSourceImp(this.supabaseClient);

  @override
  Future<WordPoolModel> uploadToWordPool(WordPoolModel wordPoolModel) async {
    try {
      //verileri vermek için map oluşturduk.
      //select olmazsa data - dynamic olur , olursa data - List<Map<String, dynamic>> olur
      final data =
          await supabaseClient
              .from('wordpool')
              .insert(wordPoolModel.toJson())
              .select();

      return WordPoolModel.fromJson(data.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<WordPoolModel>> fetchAllWords(String id, bool isItLearned) async {
    try {
      final res = await supabaseClient
          .from('wordpool')
          .select()
          .eq('learning_process_id', id)
          .eq('is_it_learned', isItLearned)
          .order('updated_at', ascending: false);

      return res.map((word) => WordPoolModel.fromJson(word)).toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<(String?, int)> fetchLearningProcessSummary(
    String processId,
    bool isItLearned,
  ) async {
    try {
      final lastWordRes = await supabaseClient
          .from('wordpool')
          .select('word')
          .eq('learning_process_id', processId)
          .eq('is_it_learned', isItLearned)
          .order('updated_at', ascending: false)
          .limit(1);

      final lastWord =
          lastWordRes.isNotEmpty ? lastWordRes.first['word'] as String : null;

      final countRes = await supabaseClient
          .from('wordpool')
          .select('id')
          .eq('learning_process_id', processId)
          .eq('is_it_learned', isItLearned)
          .count(CountOption.exact);

      final int count = countRes.count;

      return (lastWord, count);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> removeWord(String id) async {
    try {
      final response = await supabaseClient
          .from('wordpool')
          .delete()
          .eq('id', id)
          .select('id');

      return response.first.isNotEmpty;
      
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<bool> addToPiggyBank(String id) async{
    try{
      final response = await supabaseClient.from('wordpool').update({'is_it_learned':true}).eq('id', id).select('id');

      return response.isNotEmpty;


    } on PostgrestException catch(e){
      throw ServerException(e.message);
    } catch(e){
      throw ServerException(e.toString());
    }
    
  }
}
