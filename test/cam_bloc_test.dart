import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medid/src/blocs/cam_bloc.dart';
import 'package:medid/src/blocs/states/cam_state.dart';
import 'package:medid/src/blocs/events/cam_event.dart';
import 'package:mockito/mockito.dart';


class MockCameraDescription extends Mock implements CameraDescription {}
class MockCameraController extends Mock implements CameraController {}
class MockDirectoryWrapper extends Mock implements DocumentDirectoryData {}
class MockLamp extends Mock implements LampSwitcher {}

void main() {
  CamBloc sut;

  group('Cam Bloc Tests:', (){
    group('From CamInitialised state, on CamTakePictureEvent', () {
      setUp(() {
        sut = new CamBloc(lampSwitcher: new MockLamp());
        sut.isDirPathLoaded = true;

        List<MockCameraDescription> cameras = new List<MockCameraDescription>();
        cameras.add(new MockCameraDescription());

        MockCameraController controller = new MockCameraController();

        sut.currentState.availableCameras = cameras;
        sut.currentState.controller = controller;

        when(sut.currentState.controller.value).thenReturn(
          new CameraValue(isInitialized: true, isTakingPicture: false)
        );

        when(sut.lamp.hasLamp()).thenAnswer((_) => Future<bool>(() => false));

        sut.dispatch(CamInitEvent());
      });
      test("Emits [CamInitialized, CamError] on capture picture error", () {
        expectLater(sut.state, emitsInOrder([CamUninitialized(), CamInitialized(sut.currentState.availableCameras, sut.currentState.controller), sut.errors[1]]));

        when(sut.currentState.controller.takePicture(any)).thenThrow(new CameraException("", ""));

        sut.dispatch(OnTakePictureEvent());
      });

      test("Returns if the camera is already taking picture", () {
        expectLater(sut.state, emitsInOrder([CamUninitialized(), CamInitialized(sut.currentState.availableCameras, sut.currentState.controller)]));
        
        when(sut.currentState.controller.value).thenReturn(
          new CameraValue(isInitialized: true, isTakingPicture: true)
        );

        sut.dispatch(OnTakePictureEvent());
      });

      test("Emits [CamInitialized, CamPictureTaken] on no errors", (){
        //String filePath = "$dirPath/${new DateTime.now().toString().replaceAll(' ', '')}.jpg";
        expectLater(sut.state, emitsInOrder([CamUninitialized(), CamInitialized(sut.currentState.availableCameras, sut.currentState.controller), CamPictureTaken("IMAGE STRING", sut.currentState.availableCameras, sut.currentState.controller)]));

        when(sut.currentState.controller.value).thenReturn(
            new CameraValue(isInitialized: true, isTakingPicture: false)
          );

        when(sut.currentState.controller.takePicture(any)).thenAnswer((_) {});

        sut.dispatch(OnTakePictureEvent());
      });
    });
    group('From CamUninitialised state, on camInitEvent -', () {
      setUp(() {
        sut = new CamBloc(lampSwitcher: new LampSwitcher());
        sut.isDirPathLoaded = true;

        when(sut.lamp.hasLamp()).thenAnswer((_) => Future<bool>(() => false));
      });
      test('Initial state is CamUninitialized', () {
        expect(sut.initialState, CamUninitialized());
      });

      test('Emits [CamUninitialized, CamError] on non-existing event', () {
        expectLater(
            sut.state, emitsInOrder([CamUninitialized(), sut.errors[7]])).then((_) {
              
            });

        sut.dispatch(CamIdleEvent());
      });

      test('Emits [CamUninitialized, CamError] on takePictureEvent', () {
        expectLater(
            sut.state, emitsInOrder([CamUninitialized(), sut.errors[0]]));
        sut.dispatch(OnTakePictureEvent());
      });

      test('Emits [CamUninitialized, CamError] on !dirPathLoaded', () {
        sut.isDirPathLoaded = false;

        expectLater(
            sut.state, emitsInOrder([CamUninitialized(), sut.errors[2]]));

        sut.dispatch(CamInitEvent());
      });

      test('Emits [CamUninitialized, CamError] for camera init error', () {
        expectLater(
            sut.state, emitsInOrder([CamUninitialized(), sut.errors[3]]));

        sut.dispatch(CamInitEvent());
      });

      test('Emits [CamUninitialized, CamError] for empty cam list', () {
        sut.currentState.availableCameras = List<MockCameraDescription>();

        expectLater(
            sut.state, emitsInOrder([CamUninitialized(), sut.errors[4]]));

        sut.dispatch(CamInitEvent());
      });

      test('Emits [CamUninitialized, CamError] for faulty camera', () {
        sut.currentState.availableCameras = List<MockCameraDescription>();
        sut.currentState.availableCameras.add(new MockCameraDescription());

        expectLater(
            sut.state, emitsInOrder([CamUninitialized(), sut.errors[5]]));

        sut.dispatch(CamInitEvent());
      });

      test('Emits [CamUninitialized, CamError] for faulty controller', () {
        sut.currentState.availableCameras = List<MockCameraDescription>();
        sut.currentState.availableCameras.add(new MockCameraDescription());

        sut.currentState.controller = new MockCameraController();

        expectLater(sut.state, emitsInAnyOrder([CamUninitialized(), sut.errors[6]]));

        sut.dispatch(CamInitEvent());
      });

      test(
        'Emits [CamUninitialized, CamInitialised] for proper cameras and a valid controller',
        () {
        sut.isDirPathLoaded = true;
        sut.currentState.availableCameras = List<MockCameraDescription>();
        sut.currentState.availableCameras.add(new MockCameraDescription());

        sut.currentState.controller = new MockCameraController();

        expectLater(
            sut.state,
            emitsInAnyOrder([
              CamUninitialized(),
              CamInitialized(
                  sut.currentState.availableCameras, sut.currentState.controller)
            ]));
        
        when(sut.currentState.controller.value).thenReturn(new CameraValue(isInitialized: true));

        sut.dispatch(CamInitEvent());
      });
    });
    group('LoadDirectoryData function tests', () {
      MockDirectoryWrapper docWrapper;
      setUp(() {
        docWrapper = new MockDirectoryWrapper();

        sut = new CamBloc(dirDoc: docWrapper);
        when(sut.lamp.hasLamp()).thenAnswer((_) => Future<bool>(() => false));
      });
      test('extDir or dirPath != null, return true', () async {
        sut.dirPath = "test!";
        sut.extDir = new Directory("testPath");

        expect(await sut.loadDirectoryData(), true);
      });

      test('_extDir is null due to it not being loaded', () async {
        when(sut.directoryWrapper.documentsDirectory()).thenAnswer((_) => Future<Directory>(() {return null;}));

        expect(await sut.loadDirectoryData(), false);
        verify(sut.directoryWrapper.documentsDirectory).called(2);
      });

      test('Directory is being succesfully loaded', () async {
        when(sut.directoryWrapper.documentsDirectory()).thenAnswer((_) => Future<Directory>(() {return new Directory("Test");}));
        when(sut.directoryWrapper.createDirectory("test")).thenAnswer((_) => Future<void>(() {}));

        expect(await sut.loadDirectoryData(), true);
      });
    });
  });
}
