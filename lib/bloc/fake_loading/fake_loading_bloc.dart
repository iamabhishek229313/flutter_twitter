import 'package:bloc/bloc.dart';
enum TriggerChange {
  FALSE,
  TRUE
} 



class FakeLoadingBloc extends Bloc<TriggerChange, bool> {
  @override
  bool get initialState => false;

  @override
  void onTransition(Transition<TriggerChange, bool> transition) {
    print(transition);
  }

  @override
  Stream<bool> mapEventToState(
    TriggerChange event,
  ) async* {
    switch(event){
      case TriggerChange.TRUE:
        yield true;
        break;
      case TriggerChange.FALSE:
        yield false;
        break;
    }
  }
}