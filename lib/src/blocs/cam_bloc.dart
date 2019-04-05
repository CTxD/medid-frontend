import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:medid/src/blocs/events/cam_event.dart';
import 'package:medid/src/blocs/states/cam_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:lamp/lamp.dart';



class CamBloc extends Bloc<CamEvent, CamState> {
  final List<CamState> errors = [
    CamError("Kameraet kunne ikke blive initialiseret"),
    CamError("Kameraet kunne ikke tage et billede"),
    CamError("Fotobiblioteket kunne ikke findes"),
    CamError("Ingen kameraer blev fundet"),
    CamError("Ingen kameraer kan bruges"),
    CamError("Kameraet kunne ikke blive initialiseret"),
    CamError("Kameraet kunne ikke konfigueres"),
    CamError("Denne handling kan ikke udføres!"),
  ];

  Directory extDir;
  String dirPath;
  String recentImageString;

  bool isDirPathLoaded = false;

  DocumentDirectoryData directoryWrapper;
  LampSwitcher lamp;

  CamBloc({DocumentDirectoryData dirDoc, LampSwitcher lampSwitcher}){
    directoryWrapper = dirDoc == null ? new DocumentDirectoryData() : dirDoc;
    lamp = lampSwitcher == null ? new LampSwitcher() : lampSwitcher;

    loadDirectoryData().then((pathLoadedStatus) {
      isDirPathLoaded = pathLoadedStatus;
    }).catchError((_) {

    });
  }

  @override
  get initialState => CamUninitialized();

  @override
  Stream<CamState> mapEventToState(CamState currentState, CamEvent event) async* {
    if(event is OnTakePictureEvent){
      // Check if camera is currently taking a picture
      if(currentState.controller.value.isTakingPicture){
        yield currentState;
        return;
      }

      String filePath = "$dirPath/${new DateTime.now().toString().replaceAll(' ', '')}.jpg";
      
      // Take the picture
      try{
        lamp.hasLamp().then((res) {
          if(res == true){
            lamp.turnOn();
          }
        }).catchError((_) {});
        await currentState.controller.takePicture(filePath);
      }catch(_){
        lamp.hasLamp().then((res) {
          if(res == true){
            lamp.turnOff();
          }
        }).catchError((_) {});

        yield errors[1];
        return;
      }

      yield CamPictureTaken(filePath, currentState.availableCameras, currentState.controller);
        lamp.hasLamp().then((res) {
          if(res == true){
            lamp.turnOff();
          }
        }).catchError((_) {
          
        });
    }else if(event is CamInitEvent){
      if(currentState is CamUninitialized){
        List<CameraDescription> cameras = currentState.availableCameras;
        CameraController controller = currentState.controller;

        // Only do this if the camera is not already initialised
        List<CameraDescription> cameraList;
        if(cameras == null){
          try{
            cameraList = await availableCameras();

            if(cameraList.length < 1){
              yield errors[4];
              return;
            }

            // Set camera
            cameras = cameraList;
          }catch(_){
            yield errors[3];
            return;
          }
        }

        if(cameras.length < 1){
            yield errors[4];
            return;
        }


        if(controller == null) {
          // Initialize controller
          controller = CameraController(cameras.first, ResolutionPreset.high);
            
          try{
            await controller.initialize();
          }catch(_){
            yield errors[5];
            return;
          }
        }

        // Check if it was initialised
        if(controller.value == null || !controller.value.isInitialized){
          yield errors[6];
          return;
        }
          
        yield CamInitialized(cameras, controller);
      }
    }else{
      yield errors[7];
      return;
    }
  }

  Future<bool> loadDirectoryData() async {
    if(extDir != null && dirPath != null){
      return true;
    }

    Directory _extDir;

    try{
      _extDir = await directoryWrapper.documentsDirectory();
    }catch(e){
      _extDir = null;
    }

    if(_extDir == null) {
      return false;
    }
 
    extDir = _extDir;

    dirPath = "${extDir.path}/Pictures/med_id";

    await directoryWrapper.createDirectory(dirPath);

    return true;
  }
}

class LampSwitcher {
  Future<bool> hasLamp() => Lamp.hasLamp;

  void turnOn(){
    Lamp.turnOn();
  }

  void turnOff() {
    Lamp.turnOff();
  }

}

class DocumentDirectoryData {
  Future<Directory> documentsDirectory() => getApplicationDocumentsDirectory();

  Future<void> createDirectory(String dirPath, ) async {
    Directory(dirPath).create(recursive: false).then((_) {});
  }
}