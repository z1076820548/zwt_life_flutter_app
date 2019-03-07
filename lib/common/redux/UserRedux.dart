import 'package:redux/redux.dart';
import 'package:zwt_life_flutter_app/common/model/User.dart';

//redux的combineReducers,通过TypedReducer将updateUserAction与reducers关联起来
final UserReducer = combineReducers<User>([
  TypedReducer<User, UpdateUserAction>(_updateLoaded),
]);

class UpdateUserAction {
  final User userInfo;
  UpdateUserAction(this.userInfo);
}

User _updateLoaded(User state, action) {
  state = action.userInfo;
  return state;
}
