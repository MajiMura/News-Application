import 'dart:async';
import 'package:news_app/src/models/item_model.dart';

import 'news_api_provider.dart';
import 'news_db_provider.dart';

class Repository {
  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  Future<List<int>> fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  Future<ItemModel?> fetchItem(int id) async {
    var item = await dbProvider.fetchItem(id);
    if (item != null) {
      return item;
    }

    item = await apiProvider.fetchItem(id);
    if (item != null) {
      dbProvider.addItem(item);
    }

    return item;
  }
}
