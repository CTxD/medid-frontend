import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:medid/src/blocs/events/cam_event.dart';
import 'package:medid/src/blocs/states/cam_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:lamp/lamp.dart';

class CamBloc extends Bloc<CamEvent, CamState> {
  Directory extDir;
  String dirPath;
  String recentImageString;

  bool isDirPathLoaded = false;

  CamBloc(){
    loadDirectoryData().then((pathLoadedStatus) {
      isDirPathLoaded = pathLoadedStatus;
    });
  }

  @override
  get initialState => CamUninitialized();



  @override
  Stream<CamState> mapEventToState(CamState currentState, CamEvent event) async* {
    if(event is onTakePictureEvent){
      // Check if camera is initialised
      if(!currentState.controller.value.isInitialized){
        yield CamError("Kameraet kunne ikke blive initialiseret");
        return;
      }

      // Check if camera is currently taking a picture
      if(currentState.controller.value.isTakingPicture){
        yield currentState;
        return;
      }

      String filePath = "$dirPath/${new DateTime.now().toString().replaceAll(' ', '')}.jpg";

      // Take the picture
      try{
        Lamp.turnOn();
        await currentState.controller.takePicture(filePath);
      }on CameraException{
        yield CamError("Kameraet kunne ikke tage et billede");
        return;
      }

      // Take the picture
      yield CamPictureTaken(filePath, currentState.availableCameras, currentState.controller);
      Lamp.turnOff();
    }else if(event is camInitEvent){
      if(currentState is CamUninitialized){
        // Check if directory data has been loaded
        if(!isDirPathLoaded){
          // Try again
          await loadDirectoryData();
          if(!isDirPathLoaded){
            // Can't be done.
            yield CamError("Fotobiblioteket kunne ikke findes");
            return;
          }
        }

        List<CameraDescription> cameras = currentState.availableCameras;
        CameraController controller = currentState.controller;

        List<CameraDescription> cameraList;

        try{
          cameraList = await availableCameras();
        }on CameraException{
          cameraList = null;
        }

        if(cameraList == null) {
          yield CamError("Ingen kameraer blev fundet");
          return;
        }

        // Check if cameras is found
        if(cameraList.length < 1){
          yield CamError("Ingen kameraer kan bruges");
          return;
        }

        // Set camera
        cameras = cameraList;

        // Initialize controller
        controller = CameraController(cameras.first, ResolutionPreset.high);
          
        try{
          await controller.initialize();
        }on CameraException{
          yield CamError("Kameraet kunne ikke blive initialiseret");
          return;
        }

        // Check if it was initialised
        if(!controller.value.isInitialized){
          yield CamError("Kameraet kunne ikke konfigueres");
          return;
        }
          
        yield CamInitialized(cameras, controller);
      }else{
        yield CamError("Denne handling kan ikke udføres!");
        return;
      }
    }
  }

  Future<bool> loadDirectoryData() async {
    Directory _extDir;

    try{
      _extDir = await getApplicationDocumentsDirectory();
    }catch(e){
      _extDir = null;
    }

    if(_extDir == null) {
      return false;
    }
 
    extDir = _extDir;
    dirPath = "${_extDir.path}/Pictures/med_id";

    Directory(dirPath).create(recursive: true).then((_) {});

    return true;
  }

}