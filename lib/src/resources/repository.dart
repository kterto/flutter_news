import '../modules/item_model.dart';
import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';

class Repository {
  List<Source> sources = [
    NewsApiProvider(),
    newsDbProvider,
  ];
  List<Cache> caches = [
    newsDbProvider,
  ];

  Future<List<int>> fetchTopIds() {
    return sources[0].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    Source source;
    ItemModel item;

    for(source in sources) {
      item = await source.fetchItem(id);
      if(item != null) {
        break;
      }
    }

    for(var cache in caches) {
      cache.addItem(item);
    }
    return item;
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
}