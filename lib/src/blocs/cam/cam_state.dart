import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';


abstract class CamState extends Equatable {
  List<CameraDescription> availableCameras;
  CameraController controller;
}

class CamUninitialized extends CamState {
  @override
  String toString() => "Kameraet skal initialiseres";
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
  bool operator ==(Object other) =>
  identical(this, other) ||
  other is CamError &&
  runtimeType == other.runtimeType &&
  errorMsg == other.errorMsg;

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