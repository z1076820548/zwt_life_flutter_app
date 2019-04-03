import 'package:zwt_life_flutter_app/public.dart';

//收藏管理
class CollectionsManager {
  static CollectionsManager _manager;

  CollectionsManager() {}

  static CollectionsManager getInstance() {
    if (_manager == null) {
      _manager = new CollectionsManager();
    }
    return _manager;
  }


}
