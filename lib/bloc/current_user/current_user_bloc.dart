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
    bio: null,
    emailAddress: null,
    firstName: null,
    followers: null,
    following: null,
    lastName: null,
    phoneNumber: null,
    photoURL: null,
    postCount: null,
    username: null
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