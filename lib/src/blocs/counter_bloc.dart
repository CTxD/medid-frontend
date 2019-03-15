import "package:bloc/bloc.dart";
import 'package:medid/src/blocs/counter_event.dart';
import 'package:medid/src/blocs/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  @override
  CounterState get initialState => CounterState.initial();

  @override
  Stream<CounterState> mapEventToState(CounterState currentState, CounterEvent event, ) async* {
    if(event is IncrementEvent){
      yield currentState..counter += 1;
    }else if(event is DecrementEvent){
      yield currentState..counter -= 1;
    }else{
      throw new Exception("Event Exception: Event not specified");
    }
  }
}