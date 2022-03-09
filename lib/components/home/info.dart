import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How To Play'),

      ),
      body: Container(
        color: Colors.black87,
        child: const Center(
          child: Text(
            "Guess the wordle in six tries....... TODO",style: TextStyle(color: Colors.white),

          ),
        ),

      )
    );
  }
}