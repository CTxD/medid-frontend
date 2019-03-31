abstract class CamEvent {}

class CamInitEvent implements CamEvent{}
class OnTakePictureEvent implements CamEvent{}
class CamIdleEvent implements CamEvent{}