import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medid/src/blocs/cam_bloc.dart';
import 'package:medid/src/blocs/states/cam_state.dart';
import 'package:medid/src/blocs/events/cam_event.dart';
import 'package:medid/src/ui/cam_page.dart';
import 'package:medid/src/ui/cam_result.dart';
import 'package:mockito/mockito.dart';


class MockCameraDescription extends Mock implements CameraDescription {}
class MockCameraController extends Mock implements CameraController {}
class MockDirectoryWrapper extends Mock implements DocumentDirectoryData {}
class MockLamp extends Mock implements LampSwitcher {}
class MockCameraPreviewWidget extends Mock implements CameraPreviewWidget {}
class MockNavigator extends Mock implements NavigatorObserver {}
class MockCamBloc extends Mock implements CamBloc {
  StreamController<CamState> ctrl = StreamController<CamState>.broadcast();

  get state => ctrl.stream;

  MockCamBloc() {
    MockCameraController controller = MockCameraController();
    List<MockCameraDescription> cams = List<MockCameraDescription>();
    cams.add(MockCameraDescription());

    final path = "test/path";

    ctrl.sink.add(CamPictureTaken(path, cams, controller));
    ctrl.sink.close();
  }
}

void main() {
  CamBloc sut;

  group('Cam Bloc Test:', (){
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

      test("Emits [CamInitialized, CamPictureTaken] on no errors", (){
        //String filePath = "$dirPath/${new DateTime.now().toString().replaceAll(' ', '')}.jpg";
        expectLater(sut.state, emitsInOrder([CamUninitialized(), CamInitialized(sut.currentState.availableCameras, sut.currentState.controller), CamPictureTaken("IMAGE STRING", sut.currentState.availableCameras, sut.currentState.controller)]));

        when(sut.currentState.controller.value).thenReturn(
            new CameraValue(isInitialized: true, isTakingPicture: false)
          );

        sut.dispatch(OnTakePictureEvent());
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
    });
    group('From CamUninitialised state, on camInitEvent -', () {
      setUp(() {
        sut = new CamBloc(lampSwitcher: new MockLamp());
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

      test('Emits [CamUninitialized, CamError] for camera init error', () {
        expectLater(
            sut.state, emitsInOrder([CamUninitialized(), sut.errors[3]]));

        sut.dispatch(CamInitEvent());
      });

      test('Emits [CamUninitialized, CamError] for empty cam list', () {
        sut.currentState.availableCameras = List<MockCameraDescription>();

        expectLater(
            sut.state, emitsInOrder([CamUninitialized(), sut.errors[6]]));

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

        expectLater(sut.state, emitsInAnyOrder([CamUninitialized(), sut.errors[0]]));

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

        sut = new CamBloc(dirDoc: docWrapper, lampSwitcher: new MockLamp());
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
      });

      test('Directory is being succesfully loaded', () async {
        when(sut.directoryWrapper.documentsDirectory()).thenAnswer((_) => Future<Directory>(() {return new Directory("Test");}));
        when(sut.directoryWrapper.createDirectory("test")).thenAnswer((_) => Future<void>(() {}));

        expect(await sut.loadDirectoryData(), true);
      });
    });
  });
  group('Cam Widget Test:', () {
    MockCamBloc camBloc;

    MockNavigator navigatorObserver;
    MockCameraPreviewWidget cameraPreview;
    Widget sut;

    setUp(() {
      navigatorObserver = MockNavigator();

      camBloc = MockCamBloc();
      cameraPreview = MockCameraPreviewWidget();


      when(cameraPreview.getCameraPreview(null)).thenReturn(null);

      sut = MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          navigatorObservers: [navigatorObserver],
          home: CamPage(camBloc: camBloc, cameraPreview: cameraPreview)
        ),
      );
    });

    testWidgets("InitState calls new navigation on CamPicTaken", (tester) async {
      MockCameraController controller = MockCameraController();
      List<MockCameraDescription> cams = List<MockCameraDescription>();
      cams.add(MockCameraDescription());

      when(controller.value).thenAnswer((_) => CameraValue(isInitialized: true, previewSize: Size(2000, 2000)));
      when(camBloc.currentState).thenAnswer((_) => CamInitialized(cams, controller));

      await tester.pumpWidget(sut);

      verify(navigatorObserver.didPush(any, any));
    });

    testWidgets("Correct tile in the app bar", (tester) async {
      when(camBloc.currentState).thenAnswer((_) => CamUninitialized());

      await tester.pumpWidget(sut);

      final titleFinder = find.descendant(
           of: find.byType(Scaffold),
           matching: find.byWidgetPredicate((Widget w) =>
               w is AppBar && (w.title as Text).data == "Identificer Pille"));
      
      expect(titleFinder, findsOneWidget);
    });

    testWidgets("Correct text is rendered on CamUninitialised state", (WidgetTester tester) async {
      when(camBloc.currentState).thenAnswer((_) => CamUninitialized());
      
      await tester.pumpWidget(sut);

      expect(find.text("Kameraet indlæses - vent venligst."), findsOneWidget);            
    });

    testWidgets("Correct text and button is rendered on CamError state", (tester) async {
      String errorMsg = "Testing Error";
      final retryButton = find.byType(FloatingActionButton);

      when(camBloc.currentState).thenAnswer((_) => CamError("$errorMsg"));
      when(camBloc.dispatch(CamInitEvent())).thenAnswer((_) => true);

      await tester.pumpWidget(sut);

      expect(find.text("$errorMsg"), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.text("Prøv Igen"), findsOneWidget);

      tester.press(retryButton);
    });

    testWidgets("The correct overlay and button is rendered, when the state is CamInitialised", (tester) async {
      MockCameraController controller = MockCameraController();
      List<MockCameraDescription> cams = List<MockCameraDescription>();
      cams.add(MockCameraDescription());

      when(controller.value).thenAnswer((_) => CameraValue(isInitialized: true, previewSize: Size(2000, 2000)));
      when(camBloc.currentState).thenAnswer((_) => CamInitialized(cams, controller));

      await tester.pumpWidget(sut);

      expect(find.byType(CustomPaint), findsNWidgets(3));
      
      tester.tap(find.byType(Ink));
    });

    testWidgets("Correct information is rendered upon PictureTakenState", (tester) async {
      MockCameraController controller = MockCameraController();
      List<MockCameraDescription> cams = List<MockCameraDescription>();
      cams.add(MockCameraDescription());

      final path = "test/path";

      when(camBloc.currentState).thenAnswer((_) => CamPictureTaken(path, cams, controller));
      when(camBloc.dispatch(OnTakePictureEvent())).thenAnswer((_) => true);

      await tester.pumpWidget(sut);

      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);
      expect(find.text("Tager billedet, vent venligst."), findsOneWidget);
    });
  });
}