import 'package:aadaiz_customer_crm/src/views/consulting/controller/consulting_controller.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgoraVideoCallScreen extends StatefulWidget {
  final String channelName;
  final String token;
  final int uid;
  final int videoId;

  const AgoraVideoCallScreen({
    super.key,
    required this.channelName,
    required this.token,
    required this.uid,
    required this.videoId,
  });

  @override
  State<AgoraVideoCallScreen> createState() => _AgoraVideoCallScreenState();
}

class _AgoraVideoCallScreenState extends State<AgoraVideoCallScreen> {

  late final RtcEngine engine;
  bool joined = false;
  int? remoteUid;
  bool endApiCalled = false;

  final String appId = "2db6113c15e748c696c5ac428edf2c0d";

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    engine = createAgoraRtcEngine();

    await engine.initialize(
      RtcEngineContext(
        appId: appId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );

    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) async {
          setState(() {
            joined = true;
          });

          await ConsultingController.to.markVideoCallStarted(
            videoId: widget.videoId,
          );
        },
        onUserJoined: (connection, uid, elapsed) {
          setState(() {
            remoteUid = uid;
          });
        },
        onUserOffline: (connection, uid, reason) {
          setState(() {
            remoteUid = null;
          });
        },
      ),
    );

    await engine.enableVideo();
    await engine.startPreview();

    await engine.joinChannel(
      token: widget.token,
      channelId: widget.channelName,
      uid: widget.uid,
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> endCall() async {
    if (endApiCalled) return;
    endApiCalled = true;

    await ConsultingController.to.markVideoCallEnded(
      videoId: widget.videoId,
    );

    await engine.leaveChannel();
    await engine.release();

    if (mounted) {
      Get.back();
    }
  }

  @override
  void dispose() {
    if (!endApiCalled) {
      ConsultingController.to.markVideoCallEnded(
        videoId: widget.videoId,
      );
      engine.leaveChannel();
      engine.release();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await endCall();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Video Call'),
          backgroundColor: Colors.black,
        ),
        body: Stack(
          children: [
            Center(
              child: remoteUid != null
                  ? AgoraVideoView(
                controller: VideoViewController.remote(
                  rtcEngine: engine,
                  canvas: VideoCanvas(uid: remoteUid),
                  connection: RtcConnection(
                    channelId: widget.channelName,
                  ),
                ),
              )
                  : const Text(
                'Waiting for user...',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Positioned(
              top: 30,
              right: 20,
              width: 120,
              height: 160,
              child: joined
                  ? AgoraVideoView(
                controller: VideoViewController(
                  rtcEngine: engine,
                  canvas: const VideoCanvas(uid: 0),
                ),
              )
                  : const SizedBox(),
            ),
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.red,
                  child: IconButton(
                    icon: const Icon(Icons.call_end, color: Colors.white),
                    onPressed: endCall,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}