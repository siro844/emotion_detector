import 'package:camera/camera.dart';
import 'package:emotion_detector/main.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

 CameraImage? cameraImage;
    CameraController? cameraController;
    String output='';

    loadCamera(){
      cameraController=CameraController(
        camera![0],
       ResolutionPreset.medium);
       cameraController!.initialize().then((value){
        if(!mounted){

        }
        else{
          setState(() {
            cameraController!.startImageStream((image) {
                cameraImage = image;
                runModel();
             });
          });
        }
       });
    }

    runModel() async{

      if(cameraImage!=null){
        var predictions = await Tflite.runModelOnFrame(bytesList: cameraImage!.planes.
        map((plane) {
          return plane.bytes;
        })
        .toList(),
        imageHeight: cameraImage!.height,
        imageWidth: cameraImage!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true,
        );
        predictions!.forEach((element) {
          setState(() {
            output=element['label'];
          });
        });
        
      }
    }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Emotion Detector')),
      ),
     
    );
  }
}