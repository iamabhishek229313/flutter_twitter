import 'package:bloc/bloc.dart';
import 'package:twitter_clone/core/database_models/userModel.dart';
abstract class CurrentUserEvent {}

class GetCurrentUser extends CurrentUserEvent {
  final User currentUser;
  GetCurrentUser(this.currentUser);
}


class CurrentUserBloc extends Bloc<CurrentUserEvent, User> {
  @override
  User get initialState => User(
    name: null,
    email_id: null,
    user_imageUrl: null
  );

  @override
  void onTransition(Transition<CurrentUserEvent, User> transition) {
    print(transition);
  }

  @override
  Stream<User> mapEventToState(
    CurrentUserEvent event,
  ) async* {
    if(event is GetCurrentUser)
     yield event.currentUser;
  }
}