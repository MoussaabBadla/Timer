import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'cubit/timer_cubit.dart';
import 'flipanimation.dart';

void main() => runApp(
      BlocProvider(
        create: (context) => TimerCubit(),
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    context.read<TimerCubit>().startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TimerCubit, TimerState>(
      listener: (context, state) {},
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color(0xA0132E4B),
                  Color(0xff132E4B),
                ])),
            child: Stack(
              children: [
                Positioned(
                    left: 0,
                    bottom: 400,
                    child: Image.asset(
                      'assets/topleft.png',
                      fit: BoxFit.none,
                    )),
                Positioned(
                    right: 0,
                    bottom: 400,
                    child: Image.asset(
                      'assets/topright.png',
                      fit: BoxFit.none,
                    )),
                Positioned(
                    left: 0,
                    top: 400,
                    child: Image.asset(
                      'assets/bottomleft.png',
                      fit: BoxFit.none,
                    )),
                Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Lottie.asset('assets/Comp.json')),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Lottie.asset('assets/130731-snow-no-santa.json'),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocBuilder<TimerCubit, TimerState>(
                      builder: (context, state) {
                        if (state is TimerBegin) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FlipPanel.builder(
                                direction: FlipDirection.down,
                                itemBuilder: (context, index) => ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10.0, sigmaY: 10.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 96.0,
                                      height: 128.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          color: Color(0xff1E4167)
                                              .withOpacity(0.5)),
                                      child: Text(
                                        state.hours,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 80.0,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                itemsCount: 10,
                                period: state.hoursduration,
                                loop: 1,
                              ),
                              FlipPanel.builder(
                                direction: FlipDirection.down,
                                itemBuilder: (context, index) => ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10.0, sigmaY: 10.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 96.0,
                                      height: 128.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          color: Color(0xff1E4167)
                                              .withOpacity(0.5)),
                                      child: Text(
                                        state.minutes,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 80.0,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                itemsCount: 10,
                                period: state.minduration,
                                loop: 1,
                              ),
                              FlipPanel.builder(
                                direction: FlipDirection.down,
                                itemBuilder: (context, index) => ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10.0, sigmaY: 10.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 96.0,
                                      height: 128.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          color: Color(0xff1E4167)
                                              .withOpacity(0.5)),
                                      child: Text(
                                        state.seconds,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 80.0,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                itemsCount: 10,
                                period: const Duration(seconds: 1),
                                loop: 1,
                              ),
                            ],
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

