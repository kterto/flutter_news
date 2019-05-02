import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart';
// import 'package:news/src/modules/item_model.dart';

void main() {
  test('fetchTopIds returns a list of ids', () async {
    //setup of test case
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    final ids = await newsApi.fetchTopIds();

    // Expectation
    expect(ids, [1, 2, 3, 4]);

  });

  test('fetchItem returns a item model', () async {
    // setup of test case
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final jsonMap = {'id: 123'};
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(999);

    // Expectation
    expect(item.id, 123);
  });
}