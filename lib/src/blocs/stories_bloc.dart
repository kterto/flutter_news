import 'package:rxdart/rxdart.dart';
import '../modules/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _topIds = PublishSubject<List<int>>();
  final _items = BehaviorSubject<int>();
  final _repository = Repository();

  Observable<Map<int, Future<ItemModel>>> items;

  // Getters to streams
  Observable<List<int>> get topIds => _topIds.stream;

  // Getters to sinks
  Function(int) get fetchItem => _items.sink.add;

  StoriesBloc() {
    items = _items.stream.transform(_itemsTransformer());
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, _) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>> {},
    );
  }

  // Closing opened Streams
  dispose() {
    _topIds.close();
    _items.close();
  }
}