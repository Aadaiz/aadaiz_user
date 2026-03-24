import 'dart:async';
import 'dart:developer';

import 'package:aadaiz_customer_crm/src/views/customer_crm/chat/controller/ChatMessageController.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/chat/controller/call_controller.dart';
import 'package:aadaiz_customer_crm/src/views/dashboard/dashboard.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class VoiceCallScreen extends StatefulWidget {
  final String appId;
  final String token;
  final String channelName;
  final dynamic callId;
  final String? callerName;

  const VoiceCallScreen({
    super.key,
    required this.appId,
    required this.token,
    required this.channelName,
    required this.callId,
    this.callerName,
  });

  @override
  State<VoiceCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen> {
  late RtcEngine engine;
  bool localJoined = false;
  bool remoteJoined = false;
  bool isSpeakerOn = true;
  bool isMicrophoneMuted = false;
  bool showCallControls = true;
  bool _hasError = false;
  Timer? _hideControlsTimer;
  Duration _callDuration = Duration.zero;
  late Timer _callTimer;
  CallStateController callCon = Get.find<CallStateController>();
  ChatMessageController chatMessageController = Get.find<ChatMessageController>();

  static const Color _primaryGreen = Color(0xFF25D366);
  static const Color _darkBackground = Color(0xFF0F1B2D);
  static const Color _cardBackground = Color(0xFF1E2B3E);
  final Color _iconColor = Colors.white70;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeCall();
    });
  }

  Future<void> _initializeCall() async {
    try {
      await initAgora();
      _startCallTimer();
      _startHideControlsTimer();
    } catch (e, stack) {
      log("Initialization error: $e\n$stack");
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  Future<void> initAgora() async {
    try {
      // Request permissions
      await Permission.microphone.request();
      await Permission.bluetoothConnect.request();

      // Initialize engine
      engine = createAgoraRtcEngine();
      await engine.initialize(RtcEngineContext(appId: widget.appId));

      // Register event handlers
      engine.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (connection, elapsed) {
            if (!mounted) return;
            log("Local joined");
            setState(() => localJoined = true);
          },
          onUserJoined: (connection, remoteUid, elapsed) {
            if (!mounted) return;
            log("Remote joined");
            setState(() => remoteJoined = true);
          },
          onUserOffline: (connection, remoteUid, reason) {
            log("Remote left");
            _endCall();
          },
          onError: (error, msg) {
            log("Agora error: $error, $msg");
          },
        ),
      );

      await engine.setChannelProfile(
          ChannelProfileType.channelProfileCommunication);
      await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
      await engine.enableAudio();
      await engine.setDefaultAudioRouteToSpeakerphone(true);

      await engine.joinChannel(
        token: widget.token,
        channelId: widget.channelName,
        uid: 0,
        options: const ChannelMediaOptions(),
      );
    } catch (e, stack) {
      log("Agora initialization error: $e\n$stack");
      rethrow;
    }
  }

  void _startCallTimer() {
    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted && remoteJoined) {
        setState(() {
          _callDuration += const Duration(seconds: 1);
        });
      }
    });
  }

  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && remoteJoined && showCallControls) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              showCallControls = false;
            });
          }
        });
      }
    });
  }

  void _toggleControlsVisibility() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      setState(() {
        showCallControls = !showCallControls;
      });

      if (showCallControls && remoteJoined) {
        _startHideControlsTimer();
      }
    });
  }

  Future<void> _toggleSpeaker() async {
    try {
      await engine.setEnableSpeakerphone(!isSpeakerOn);
      if (mounted) {
        setState(() {
          isSpeakerOn = !isSpeakerOn;
        });
      }
    } catch (e) {
      log("Error toggling speaker: $e");
    }
  }

  Future<void> _toggleMicrophone() async {
    try {
      final bool wantToMute = !isMicrophoneMuted;
      await engine.muteLocalAudioStream(wantToMute);

      if (mounted) {
        setState(() {
          isMicrophoneMuted = wantToMute;
        });
      }

      log("Microphone: ${isMicrophoneMuted ? 'MUTED' : 'UNMUTED'}");
    } catch (e) {
      log("Error toggling microphone: $e");
    }
  }

  bool _hasNavigated = false;

  Future<void> _endCall() async {
    if (_hasNavigated) return;
    _hasNavigated = true;

    _callTimer.cancel();
    _hideControlsTimer?.cancel();

    callCon.endCall();
    // try {
    //   await chatMessageController.callEnd(widget.callId);
    //   log("📴 callEnded API called with callId: ${widget.callId}");
    // } catch (e) {
    //   log("❌ callEnded API error: $e");
    // }

    try {
      await engine.leaveChannel();
      await engine.release();
    } catch (_) {}

    if (!mounted) return;

    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      Get.offAll(() => const Dashboard());
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void dispose() {
    _callTimer.cancel();
    _hideControlsTimer?.cancel();

    try {
      engine.leaveChannel();
      engine.release();
    } catch (e) {
      log("Error in dispose: $e");
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Scaffold(
        backgroundColor: _darkBackground,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 64),
                const SizedBox(height: 20),
                 Text(
                  'Call Failed',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 24),
                ),
                const SizedBox(height: 10),
                 Text(
                  'Please try again',
                  style: GoogleFonts.inter(color: Colors.white70),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _endCall,
                  child: const Text('Go Back'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final String statusText = localJoined
        ? (remoteJoined ? "Connected" : "Calling...")
        : "Joining...";

    return GestureDetector(
      onTap: _toggleControlsVisibility,
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: _darkBackground,
        body: SafeArea(
          child: Stack(
            children: [
              // Background
              Positioned.fill(
                child: Container(
                  color: _darkBackground,
                ),
              ),

              // Main Content
              Column(
                children: [
                  // Header
                  AnimatedOpacity(
                    opacity: showCallControls ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon:
                            const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () {},
                          ),
                           Text(
                            " Voice Call",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Main Content
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Call Icon
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: remoteJoined
                                ? _primaryGreen.withOpacity(0.2)
                                : Colors.blueGrey.shade800,
                            border: Border.all(
                              color: remoteJoined ? _primaryGreen : Colors.white24,
                              width: 3,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(
                                remoteJoined ? Icons.mic : Icons.call,
                                size: 60,
                                color: remoteJoined
                                    ? (isMicrophoneMuted
                                    ? Colors.red
                                    : _primaryGreen)
                                    : Colors.white70,
                              ),
                              if (remoteJoined && isMicrophoneMuted)
                                Positioned(
                                  bottom: 10,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.block,
                                      size: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Caller Name
                        Text(
                          widget.callerName ?? widget.channelName,
                          style:  GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Status
                        Text(
                          statusText,
                          style: GoogleFonts.inter(
                            color: remoteJoined ? _primaryGreen : Colors.white70,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 5),

                        // Call Duration
                        if (remoteJoined)
                          Text(
                            _formatDuration(_callDuration),
                            style:  GoogleFonts.inter(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                        const SizedBox(height: 50),

                        // Waiting Indicator
                        if (!remoteJoined && localJoined)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: _cardBackground.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                 Text(
                                  "Waiting for response...",
                                  style: GoogleFonts.inter(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Bottom Controls
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: showCallControls
                        ? Container(
                      key: const ValueKey('controls'),
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: _cardBackground,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildControlButton(
                                icon: isMicrophoneMuted
                                    ? Icons.mic_off_rounded
                                    : Icons.mic_rounded,
                                label: isMicrophoneMuted ? "Unmute" : "Mute",
                                backgroundColor: isMicrophoneMuted
                                    ? Colors.red
                                    : _cardBackground,
                                onPressed: _toggleMicrophone,
                              ),
                              _buildControlButton(
                                icon: isSpeakerOn
                                    ? Icons.volume_up_rounded
                                    : Icons.volume_off_rounded,
                                label: isSpeakerOn ? "Speaker" : "Earpiece",
                                backgroundColor: isSpeakerOn
                                    ? _primaryGreen
                                    : _cardBackground,
                                onPressed: _toggleSpeaker,
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Container(
                            width: 70,
                            height: 70,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Material(
                              color: Colors.transparent,
                              shape: const CircleBorder(),
                              child: InkWell(
                                customBorder: const CircleBorder(),
                             onTap: ()async{

                               await   chatMessageController.callEnd(widget.callId);
                                  _endCall();
                             }
                                ,child: const Icon(
                                  Icons.call_end_rounded,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                           Text(
                            "End Call",
                            style: GoogleFonts.inter(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),

              // Tap Hint
              if (!showCallControls && remoteJoined)
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: _toggleControlsVisibility,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child:  Text(
                          "Tap to show controls",
                          style: GoogleFonts.inter(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white24,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onPressed,
              child: Icon(
                icon,
                size: 24,
                color: _iconColor,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style:  GoogleFonts.inter(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
