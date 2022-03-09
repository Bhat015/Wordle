import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/components/home/home_bloc.dart';
import 'package:wordle/components/home/info.dart';
import 'package:wordle/components/home/wordle/wordle.dart';

class MyHome extends StatelessWidget {
  final bool firstTime;
  const MyHome({Key? key, this.firstTime = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("W O R D L E"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const InfoPage()),);
            },
            icon:const Icon(Icons.info_outline,color: Colors.white,)
          )
        ],
      ),
      body: BlocProvider(
          create: (context) => HomeBloc()..add(OnLoadHome(firstTime)),
          child: BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is HomeLoaded) {
                  return Container(
                    color: Colors.black87,
                    child: const Wordle(),
                  );
                }
                return Scaffold(
                  body: Container(
                    color: Colors.deepPurple,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Center(
                            child: Text(
                          "W",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 48,
                              fontFamily: "Cambp"),
                        )),
                        SizedBox(
                          height: 20,
                        ),
                        Text("W O R D L E",
                            style:
                                TextStyle(fontSize: 24, color: Colors.white)),
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}
