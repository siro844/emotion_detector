import 'package:camera/camera.dart';
import 'package:emotion_detector/home.dart';
import 'package:flutter/material.dart';


List<CameraDescription>? camera;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  camera=await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.black
      ),
      home: Home(),
     
    );
  }
}