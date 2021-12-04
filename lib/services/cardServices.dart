import 'package:credit_card_project/models/card.dart';
import 'package:credit_card_project/services/server.dart';
import 'package:dio/dio.dart';

class CardServices {
  Future<List<CardModel>> getCards({required String jwt}) async {
    try {
      Response<Map> res = await dio.get('/cards',
          options: Options(headers: {"Authorization": jwt}));
      return res.data?["results"]
              ?.map<CardModel>((e) => CardModel.fromMap(e))
              .toList() ??
          [];
    } catch (e, s) {
      if (e is DioError) print(e.response);
      throw Exception("Exception occured: $e stackTrace: $s");
    }
  }

  Future<CardModel> getCard({required String id, required String jwt}) async {
    Response<Map<String, dynamic>> res = await dio.get('/cards/$id',
        options: Options(headers: {"Authorization": jwt}));
    print(res);
    return CardModel.fromMap(res.data!);
  }

  Future<bool> createCard({required Map card, required String jwt}) async {
    try {
      Response res = await dio.post('/cards',
          data: card, options: Options(headers: {"Authorization": jwt}));
      print(res.data);
      return res.statusCode == 201;
    } catch (e) {
      throw e;
    }
  }
}
