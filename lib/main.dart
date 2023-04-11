import 'package:flutter/material.dart';
import 'package:himi/sound_recorder/sound_recorder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Himi Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Himi Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final recorder = SoundRecorder();
  @override
  void initState() {
    // TODO: implement initState
    recorder.initState();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    recorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[buildStart()],
        ),
      ),
    );
  }

  Widget buildStart() {
    final isRecording = recorder.isRecording;
    final icon = isRecording ? Icons.stop : Icons.play_arrow;
    final text = isRecording ? "STOP" : "START";
    final backgroundColor = isRecording ? Colors.red : Colors.white;
    final foreGroundColor = isRecording ? Colors.white : Colors.black;
    return ElevatedButton.icon(
      onPressed: () async {
       await recorder.toggleRecording();
        setState(() {});
      },
      icon: Icon(icon),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(175, 50),
        backgroundColor: backgroundColor,
        foregroundColor: foreGroundColor,
      ),
    );
  }
}
