import 'package:camera/camera.dart';

abstract class CamState {
  List<CameraDescription> availableCameras;
  CameraController controller;
}

class CamUninitialized extends CamState {
  @override
  String toString() => "Fejl: Kameraet skal initialiseres";
}

class CamInitialized extends CamState {
  CamInitialized(List<CameraDescription> _availableCameras, CameraController _controller) {
    super.availableCameras = _availableCameras;
    super.controller = _controller;
  }

  @override
  String toString() => "Kameraet er klar";
}

class CamPictureTaken extends CamState {
  String imageFilePath;
  CamPictureTaken(String _imageFilePath, List<CameraDescription> _availableCameras, CameraController _controller){
    super.availableCameras =_availableCameras;
    super.controller =_controller;
    imageFilePath = _imageFilePath;
  }

  @override
  String toString() => "Image Path: $imageFilePath";
}

class CamError extends CamState {
  String errorMsg;
  CamError(String _errorMsg){
    errorMsg = _errorMsg;
  }

  @override
  String toString() => "Fejl: $errorMsg";
}

class CamIdle extends CamState {
  CamIdle(List<CameraDescription> _availableCameras, CameraController _controller){
    super.availableCameras =_availableCameras;
    super.controller = _controller;
  }
  @override toString() => "Sover";
}