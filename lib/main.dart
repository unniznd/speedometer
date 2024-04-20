import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedometer/screens/home.dart';
import 'package:speedometer/bloc/speed_bloc.dart';

void main(List<String> args) {
  runApp(const SpeedometerApp());
}

class SpeedometerApp extends StatelessWidget {
  const SpeedometerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Speecometer",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SpeedBloc()),
        ],
        child: const SafeArea(
          child: HomeScreen(),
        ),
      ),
    );
  }
}
