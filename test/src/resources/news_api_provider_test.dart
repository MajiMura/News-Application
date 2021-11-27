import 'package:news_app/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

main() async {
  test('FetchTopIds returns a list of ids', () async {
    // setup of test case
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });
    // expectation
    final ids = newsApi.fetchTopIds();
    expect(ids, [1, 2, 3, 4]);
  });

  test('FetchItem returns an item model', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final jsonMap = {
        'id': 123,
        'deleted': false,
        'type': 'typedata',
        'by': 'bydata',
        'time': 0,
        'text': 'textdata',
        'dead': false,
        'parent': 0,
        'kids': [1,2,3,4],
        'url': 'urldata',
        'score': 0,
        'title': 'titledata',
        'descendants': 0
      };
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(123);

    expect(item.id, 123);
  });
}
