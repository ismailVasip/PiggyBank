import 'package:piggy_bank/core/error/exceptions.dart';
import 'package:piggy_bank/features/learning_process/data/models/word_pool_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class WordPoolRemoteDataSource {
  Future<WordPoolModel> uploadToWordPool(WordPoolModel wordPoolModel);
  Future<List<WordPoolModel>> fetchAllWords(String id);
  Future<(String?, int)> fetchLearningProcessSummary(
    String processId,
    bool isItLearned,
  );
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
  Future<List<WordPoolModel>> fetchAllWords(String id) async {
    try {
      final res = await supabaseClient
          .from('wordpool')
          .select()
          .eq('learning_process_id', id);

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
}
