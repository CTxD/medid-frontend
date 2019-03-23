import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medid/src/blocs/cam_bloc.dart';
import 'package:medid/src/blocs/events/cam_event.dart';
import 'package:medid/src/blocs/states/cam_state.dart';
import 'package:medid/src/ui/cam_result.dart';

class CamPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CamPageState();
}

class _CamPageState extends State<CamPage> {
  CamBloc _camBloc = CamBloc();

  _CamPageState(){
    _camBloc.dispatch(camInitEvent());
  }

  bool _picTaken = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPersistentFrameCallback((_) {
      if(_camBloc.currentState is CamPictureTaken && !_picTaken){
        _picTaken = true;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => CamResult(
            imageFilePath: (_camBloc.currentState as CamPictureTaken).imageFilePath
          )
        ));  
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _camBloc.dispose();
  }

  @override
  Widget build(BuildContext context){
    // Retrieve the CamBloc
    return Scaffold(
      appBar: AppBar(
        title: Text("Identificer Pille")
      ),
      body: BlocBuilder<CamEvent, CamState>(
        bloc: _camBloc,
        builder: (BuildContext context, CamState state){
          if (state is CamUninitialized) {
            return Center(
              child: Text("Kameraet indlæses - vent venligst."),
            );
          }else if(state is CamError){
            return Center(
              child: Row(
                children: <Widget>[
                  Text("Noget gik galt"),
                  FloatingActionButton(
                    child: Text("Prøv Igen"),
                    onPressed: () {
                      _camBloc.dispatch(camInitEvent());
                    },
                  )
                ],
              )
            );
          }else{
            final size = MediaQuery.of(context).size;
            final deviceRatio = size.width / (size.height + size.height * .2);
            return Stack(
              children: <Widget>[
                Transform.scale(
                  scale: state.controller.value.aspectRatio / deviceRatio,
                    child: AspectRatio(
                    aspectRatio: state.controller.value.aspectRatio,
                    child: CameraPreview(state.controller),
                  ),
                ),
                Center(
                  child: CustomPaint(
                    painter: ShapesPainter(),
                    child: Container(
                      height: 2000
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 250, 0, 0),
                  child: Center(
                    child: Material (
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(75)),
                      color: Colors.transparent,
                      child: Ink.image(
                        image: AssetImage('lib/media/images/icon.png'),
                        fit: BoxFit.scaleDown,
                        width: 100,
                        height: 100,
                        child: InkWell(
                          onTap: () {
                            _camBloc.dispatch(onTakePictureEvent());
                          },
                          child: null
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );}
       }
      )
    );
  }
}

class ShapesPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    final opac = .7;

    // Variables for scaling in regards to the middle of the screen dynamically
    final offsetY = size.height * .1;
    final rectSize = size.width * .55;
    final startX = size.width * .5 - rectSize / 2;
    final startY = (size.height * .5 - rectSize / 2) - offsetY;
    final endX = startX + rectSize;
    final endY = startY + rectSize;

    // Specific for the blacked out areas
    paint.color = Color.fromRGBO(0, 0, 0, opac);

    // Top of the rect
    canvas.drawRect(Rect.fromLTRB(
      0, 
      0, 
      size.width, 
      startY), 
      paint);

    // Middle left
    canvas.drawRect(Rect.fromLTRB(
      0, 
      startY, 
      startX, 
      endY), 
      paint);

    // Middle right
    canvas.drawRect(Rect.fromLTRB(
      endX,
      startY, 
      size.width, 
      endY), 
      paint
    );

    // Bottom of rect
    canvas.drawRect(Rect.fromLTRB(
      0, 
      endY - .1, 
      size.width, 
      size.height), 
      paint);


    // The center square specifics
    paint.color = Colors.white;
    paint.strokeCap =StrokeCap.round;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = .5;

    Path customPath = Path();
    
    customPath.moveTo(startX, startY);
    customPath.lineTo(startX + rectSize, startY);
    customPath.lineTo(startX + rectSize, startY + rectSize);
    customPath.lineTo(startX, startY + rectSize);
    customPath.close();
  
    canvas.drawPath(customPath, paint);
  }

  
  

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

}