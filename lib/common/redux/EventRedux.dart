import 'package:redux/redux.dart';
import 'package:zwt_life_flutter_app/common/model/Event.dart';

final EventReducer = combineReducers<List<Event>>([
  TypedReducer<List<Event>, RefreshEventAction>(_refresh),
  TypedReducer<List<Event>, LoadMoreEventAction>(_loadMore),
]);

class LoadMoreEventAction {
  final List<Event> list;

  LoadMoreEventAction(this.list);
}

class RefreshEventAction {
  final List<Event> list;

  RefreshEventAction(this.list);
}

List<Event> _refresh(List<Event> list, action) {
  list.clear();
  if (action.list == null) {
    return list;
  } else {
    list.addAll(action.list);
    return list;
  }
}

List<Event> _loadMore(List<Event> list,  action) {
  if (action.list != null) {
     list.addAll(action.list);
  }
  return list;
}
