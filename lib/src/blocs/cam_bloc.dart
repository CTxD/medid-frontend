import 'package:camera/camera.dart';

class CamBloc{
  String _filePath;
  List<CameraDescription> _cameras;
  
  CameraController controller;
  
  bool camerasAvailable = false;

  CamBloc() {
    initialize();

    _filePath = "Photos/test.png";

    
  }

  void initialize() async {
    try{
      _cameras = await availableCameras();

      if(_cameras.length < 1){
        throw new Exception("NoCamerasFoundException");
      }

      controller = CameraController(_cameras[0], ResolutionPreset.medium);
      controller.initialize();
      
      print("Some Value!");
      print(controller.value);

      camerasAvailable = true;
    }catch(exception) {
      print(exception.toString());
      camerasAvailable = false;
    }
  }
}