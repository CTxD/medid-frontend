import "package:bloc/bloc.dart";
import 'package:medid/src/blocs/events/counter_event.dart';
import 'package:medid/src/blocs/states/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(int currentState, CounterEvent event) async* {
    if (event is IncrementEvent) {
      yield currentState += 1;
    } else if (event is DecrementEvent) {
      yield currentState -= 1;
    } else {
      throw new Exception("Event Exception: Event not specified");
    }
  }
}
