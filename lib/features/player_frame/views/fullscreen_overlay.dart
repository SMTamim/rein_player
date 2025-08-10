import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rein_player/features/player_frame/controller/fullscreen_overlay_controller.dart';
import 'package:rein_player/features/player_frame/controller/window_actions_controller.dart';
import 'package:rein_player/features/player_frame/views/window_frame.dart';
import 'package:rein_player/features/playback/views/controls_screen.dart';

class FullscreenOverlay extends StatelessWidget {
  final Widget child;

  const FullscreenOverlay({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isFullScreenMode =
          WindowActionsController.to.isFullScreenMode.value;

      if (!isFullScreenMode) {
        return child;
      }

      return Obx(() {
        return MouseRegion(
          cursor: FullscreenOverlayController.to.hideCursor.value
              ? SystemMouseCursors.none
              : SystemMouseCursors.basic,
          onHover: (event) {
            final screenSize = MediaQuery.of(context).size;
            FullscreenOverlayController.to.onMouseMove(
              event.position,
              screenSize,
            );
          },
          onExit: (_) {
            FullscreenOverlayController.to.onMouseExit();
          },
          child: Stack(
            children: [
              // Main content
              child,

              // Top menu overlay
              Obx(() {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  top: FullscreenOverlayController.to.showTopMenu.value
                      ? 0
                      : -120,
                  left: 0,
                  right: 0,
                  child: IgnorePointer(
                    ignoring: !FullscreenOverlayController.to.showTopMenu.value,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: FullscreenOverlayController.to.showTopMenu.value
                          ? 1.0
                          : 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.9),
                              Colors.black.withValues(alpha: 0.6),
                              Colors.black.withValues(alpha: 0.3),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.4, 0.7, 1.0],
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 40),
                          child: RpWindowFrame(),
                        ),
                      ),
                    ),
                  ),
                );
              }),

              // Bottom menu overlay
              Obx(() {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  bottom: FullscreenOverlayController.to.showBottomMenu.value
                      ? 0
                      : -200,
                  left: 0,
                  right: 0,
                  child: IgnorePointer(
                    ignoring:
                        !FullscreenOverlayController.to.showBottomMenu.value,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity:
                          FullscreenOverlayController.to.showBottomMenu.value
                              ? 1.0
                              : 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.9),
                              Colors.black.withOpacity(0.6),
                              Colors.black.withOpacity(0.3),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.4, 0.7, 1.0],
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 40, bottom: 20),
                          child: RpControls(),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      });
    });
  }
}
