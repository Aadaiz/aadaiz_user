
import 'dart:ui';

import 'package:aadaiz_customer_crm/src/views/customer_crm/chat/controller/call_controller.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/chat/screens/voice_call.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
class IncomingCallScreen extends StatelessWidget {
  final String callerName;
  final String channelName;
  final String token;
  final String appId;
  final dynamic callId;

  const IncomingCallScreen({
    super.key,
    required this.callerName,
    required this.channelName,
    required this.token,
    required this.appId,
    required this.callId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [

          const Positioned.fill(
              child: Icon(Icons.person)
          ),

          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white24, width: 2),
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 30),

                Text(
                  callerName,
                  style:  GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),

                 Text(
                  " Voice Call",
                  style: GoogleFonts.inter(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 100),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [


                    _buildActionButton(
                      icon: Icons.call_end,
                      backgroundColor: Colors.red,
                      iconColor: Colors.white,
                      onPressed: () {
                        final callCon = Get.find<CallStateController>();
                        callCon.isCallActive(false);

                        Get.back();}
                    ),

                    _buildActionButton(
                      icon: Icons.call,
                      backgroundColor: Colors.green,
                      iconColor: Colors.white,
                      onPressed: () {
                        Get.off(
                              () => VoiceCallScreen(
                            appId: appId,
                            token: token,
                            channelName: channelName,
                            callId: callId,
                            callerName: callerName,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildActionButton({
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: backgroundColor.withOpacity(0.4),
                blurRadius: 10,
                spreadRadius: 3,
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(icon, size: 30),
            color: iconColor,
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          icon == Icons.call_end ? "Decline" : "Accept",
          style:  GoogleFonts.inter(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
