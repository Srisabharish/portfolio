import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Gentle, breathing and floating ambient background glows
class AnimatedAmbientBackground extends StatefulWidget {
  const AnimatedAmbientBackground({super.key});

  @override
  State<AnimatedAmbientBackground> createState() => _AnimatedAmbientBackgroundState();
}

class _AnimatedAmbientBackgroundState extends State<AnimatedAmbientBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = _controller.value;
        final wobble1 = math.sin(t * math.pi * 2);
        final wobble2 = math.cos(t * math.pi * 2);

        return Stack(
          children: [
            // Top Right Orb (Primary Indigo)
            Positioned(
              top: -120 + wobble1 * 40,
              right: -120 + wobble2 * 30,
              child: Container(
                width: 550,
                height: 550,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.13 + wobble1 * 0.03),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.7],
                  ),
                ),
              ),
            ),

            // Mid Left Orb (Secondary Cyan)
            Positioned(
              top: 650 + wobble2 * 50,
              left: -180 + wobble1 * 35,
              child: Container(
                width: 650,
                height: 650,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.secondary.withValues(alpha: 0.09 + wobble2 * 0.02),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.7],
                  ),
                ),
              ),
            ),

            // Lower Right Orb (Deep Purple / Indigo)
            Positioned(
              bottom: 350 + wobble1 * 45,
              right: -160 + wobble2 * 40,
              child: Container(
                width: 600,
                height: 600,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.purple.withValues(alpha: 0.08 + wobble1 * 0.02),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.7],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
