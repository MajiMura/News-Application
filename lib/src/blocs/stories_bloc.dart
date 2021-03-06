import 'package:news_app/src/models/item_model.dart';
import 'package:news_app/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _items = BehaviorSubject<int>();

  late Stream<Map<int, Future<ItemModel?>>> items;

  // Getters to Streams
  Stream<List<int>> get topIds => _topIds.stream;

  // Getters to Sinks
  Function(int) get fetchItem => _items.sink.add;

  StoriesBloc() {
    items = _items.stream.transform(_itemsTransformer());
  }

  Future<void> fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    if (ids != null) {
      _topIds.sink.add(ids);
    }
    return;
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel?>>? cache, int id, _) {
        cache![id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel?>>{},
    );
  }

  dispose() {
    _topIds.close();
    _items.close();
  }
}
