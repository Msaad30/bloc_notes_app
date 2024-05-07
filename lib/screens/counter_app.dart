import 'package:bloc_notes_app/bloc/counter_bloc.dart';
import 'package:bloc_notes_app/bloc/counter_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CounterBloc, int>(
        builder: (BuildContext context, state) {
          return Center(
            child: Text(state.toString(), style: TextStyle(fontSize: 30),),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          context.read<CounterBloc>().add(IncrementEvent());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}