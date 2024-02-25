// **************بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيم***************
//Apps that plays the 4 violin strings for tuning
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

// 4 strings names
const List stringsNames = ['G3-Sol', 'D4-Re', 'A4-La', 'E5-Mi'];
//Map with 0 and 1 as value to check if sound is beingplayed or stopped
Map soundsState = {'G3-Sol': 1, 'D4-Re': 1, 'A4-La': 1, 'E5-Mi': 1};
//player that plays the sound
final player = AudioPlayer();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Violin 4 strings',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //'G3-Sol', 'D4-Re', 'A4-La', 'E5-Mi'
  //function that creates a button which plays note sound when pressed, and stop sound when pressed again.
  Widget buttonstring(String a) {
    return ElevatedButton(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.grey)),
      onPressed: () async {
        //state of the sound (0 or 1)
        int i = soundsState[a];
        //if not playing. play the sound
        if (i == 1) {
          debugPrint('bouvle si i=1 alors $i');
          await player.play(AssetSource('$a.wav'));
          player.onPlayerComplete.listen((_) {
            setState(() {
              player.play(AssetSource('$a.wav'));
            });
          });
          soundsState[a] = 0;

          debugPrint(' $soundsState');
        }
        // else stop the sound
        else {
          await player.stop();
          soundsState[a] = 1;
          debugPrint(' $soundsState');
        }
      },
      child: Text(a),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          " Violin 4 strings",
        ),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buttonstring(stringsNames[0]),
          buttonstring(stringsNames[1]),
          buttonstring(stringsNames[2]),
          buttonstring(stringsNames[3]),
        ],
      ),
    );
  }
}
