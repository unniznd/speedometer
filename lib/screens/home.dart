import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:speedometer/bloc/speed_bloc.dart';
import 'package:speedometer/bloc/speed_event.dart';
import 'package:speedometer/bloc/speed_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 0,
  );

  final SpeedBloc speedBloc = SpeedBloc();
  bool isDialogOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SpeedBloc, SpeedState>(
        bloc: speedBloc,
        builder: (context, state) {
          Color screenColor = Colors.white;
          if (state is OverSpeed && !isDialogOpen) {
            screenColor = Colors.red;
            // Show the alert dialog
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showAlertDialog(context);
            });
          }
          return Container(
            color: screenColor,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: StreamBuilder<Position>(
                stream: Geolocator.getPositionStream(
                  locationSettings: locationSettings,
                ),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<Position> snapshot,
                ) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  double speedInKmh = (snapshot.data!.speed * 3.6);
                  speedBloc.add(ChangeSpeed(speedInKmh));

                  return Center(
                    child: Text(
                      "${speedInKmh.toStringAsFixed(2)} km/h",
                      style: const TextStyle(
                        fontSize: 54,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Orbitron',
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    isDialogOpen = true;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Slow down"),
          content:
              const Text("You are over the speed limit. Please slow down."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                isDialogOpen = false;
              },
            ),
          ],
        );
      },
    );
  }
}
