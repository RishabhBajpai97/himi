import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import "package:permission_handler/permission_handler.dart";

const pathName = "example.aac";

class SoundRecorder {
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecorderInitialized = false;
  bool get isRecording => _audioRecorder!.isRecording;

  Future initState() async {
    _audioRecorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException(
          "Please Allow app to access microphone");
    }
    await _audioRecorder!.openAudioSession();
    _isRecorderInitialized = true;
  }

  dispose() {
    if (!_isRecorderInitialized) return;
    _audioRecorder!.closeAudioSession();
    _audioRecorder = null;
    _isRecorderInitialized = false;
  }

  Future _record() async {
    if (!_isRecorderInitialized) return;
    await _audioRecorder!.startRecorder(toFile: pathName);
  }

  Future _stop() async {
    if (!_isRecorderInitialized) return;
    String? fileUrl = await _audioRecorder!.stopRecorder();
    print(fileUrl);
  }

  Future toggleRecording() async {
    if (_audioRecorder!.isStopped) {
      await _record();
    } else {
      await _stop();
    }
  }
}
