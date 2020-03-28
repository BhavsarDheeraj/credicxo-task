import 'package:credicxo/app.dart';
import 'package:credicxo/bloc/my_bloc_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocSupervisor.delegate = MyBlocDelegate();
  runApp(App());
}
