import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_events.dart';

class CounterBloc extends Bloc<CounterEvents, int>{
  CounterBloc() : super(0){
    on<IncrementEvent>((event, emit){
      emit(state+1);
    });
  }
}