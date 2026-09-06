import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';
import 'animated_cursor.dart';

/// A card with 3D perspective tilt, flashlight radial spotlight glow,
/// and smooth spring-back physics on hover.
class InteractiveTiltCard extends StatefulWidget {
  final Widget child;
  final Color? accentColor;
  final BorderRadius? borderRadius;
  final double maxTiltAngle;
  final double hoverScale;
  final double elevation;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final String? cursorLabel;
  final bool enableTilt;
  final bool enableSpotlight;

  const InteractiveTiltCard({
    super.key,
    required this.child,
    this.accentColor,
    this.borderRadius,
    this.maxTiltAngle = 0.08, // ~4.5 degrees for subtle, premium feel
    this.hoverScale = 1.015,
    this.elevation = 12.0,
    this.padding,
    this.onTap,
    this.cursorLabel,
    this.enableTilt = true,
    this.enableSpotlight = true,
  });

  @override
  State<InteractiveTiltCard> createState() => _InteractiveTiltCardState();
}

class _InteractiveTiltCardState extends State<InteractiveTiltCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  Offset _localMousePos = Offset.zero;
  double _normalizedX = 0.0;
  double _normalizedY = 0.0;

  late final AnimationController _resetController;
  late Animation<double> _animX;
  late Animation<double> _animY;

  @override
  void initState() {
    super.initState();
    _resetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _animX = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _resetController, curve: Curves.easeOutCubic),
    );
    _animY = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _resetController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _resetController.dispose();
    super.dispose();
  }

  void _onHover(PointerEvent event, Size size) {
    if (size.width == 0 || size.height == 0) return;

    if (_resetController.isAnimating) {
      _resetController.stop();
    }

    final local = event.localPosition;
    final nx = ((local.dx / size.width) - 0.5) * 2; // -1 to 1
    final ny = ((local.dy / size.height) - 0.5) * 2; // -1 to 1

    setState(() {
      _isHovered = true;
      _localMousePos = local;
      _normalizedX = nx.clamp(-1.0, 1.0);
      _normalizedY = ny.clamp(-1.0, 1.0);
    });
  }

  void _onEnter(PointerEnterEvent event) {
    setState(() => _isHovered = true);
    final ctrl = CursorProvider.of(context);
    if (ctrl != null) {
      ctrl.setCard(
        accentColor: widget.accentColor ?? AppColors.primaryLight,
        label: widget.cursorLabel,
      );
    }
  }

  void _onExit(PointerExitEvent event) {
    CursorProvider.of(context)?.reset();

    if (!mounted) return;

    _animX = Tween<double>(begin: _normalizedX, end: 0.0).animate(
      CurvedAnimation(parent: _resetController, curve: Curves.easeOutCubic),
    );
    _animY = Tween<double>(begin: _normalizedY, end: 0.0).animate(
      CurvedAnimation(parent: _resetController, curve: Curves.easeOutCubic),
    );

    _resetController.reset();
    _resetController.forward();

    setState(() {
      _isHovered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = AppBreakpoints.isMobile(context);
    final radius = widget.borderRadius ?? BorderRadius.circular(24);
    final accent = widget.accentColor ?? AppColors.primaryLight;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;

        return MouseRegion(
          cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
          onEnter: isMobile ? null : _onEnter,
          onExit: isMobile ? null : _onExit,
          onHover: isMobile ? null : (e) => _onHover(e, Size(cardWidth, 400)),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedBuilder(
              animation: _resetController,
              builder: (context, child) {
                final currentX = _resetController.isAnimating ? _animX.value : _normalizedX;
                final currentY = _resetController.isAnimating ? _animY.value : _normalizedY;

                // 3D Perspective Matrix Calculation
                final matrix = Matrix4.identity();
                if (widget.enableTilt && !isMobile) {
                  matrix.setEntry(3, 2, 0.001); // Perspective depth
                  matrix.rotateX(-currentY * widget.maxTiltAngle);
                  matrix.rotateY(currentX * widget.maxTiltAngle);
                  if (_isHovered) {
                    matrix.scaleByDouble(widget.hoverScale, widget.hoverScale, 1.0, 1.0);
                  }
                }

                return Transform(
                  transform: matrix,
                  alignment: FractionalOffset.center,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: radius,
                      boxShadow: [
                        BoxShadow(
                          color: _isHovered
                              ? accent.withValues(alpha: 0.22)
                              : Colors.black.withValues(alpha: 0.35),
                          blurRadius: _isHovered ? widget.elevation * 2.2 : widget.elevation,
                          offset: Offset(
                            _isHovered ? currentX * 6 : 0,
                            _isHovered ? (8 + currentY * 6) : 6,
                          ),
                          spreadRadius: _isHovered ? 1 : 0,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: radius,
                      child: Stack(
                        children: [
                          // Base Background & Border
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: _isHovered
                                  ? AppColors.surfaceSubtle
                                  : AppColors.surface,
                              borderRadius: radius,
                              border: Border.all(
                                color: _isHovered
                                    ? accent.withValues(alpha: 0.75)
                                    : AppColors.cardBorder,
                                width: _isHovered ? 1.5 : 1.0,
                              ),
                            ),
                            padding: widget.padding,
                            child: widget.child,
                          ),

                          // Flashlight / Spotlight Glow following cursor
                          if (widget.enableSpotlight && _isHovered && !isMobile)
                            Positioned.fill(
                              child: IgnorePointer(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: radius,
                                    gradient: RadialGradient(
                                      center: Alignment(
                                        (_localMousePos.dx / (cardWidth > 0 ? cardWidth : 1)) * 2 - 1,
                                        (_localMousePos.dy / 300) * 2 - 1,
                                      ),
                                      radius: 0.85,
                                      colors: [
                                        accent.withValues(alpha: 0.14),
                                        Colors.transparent,
                                      ],
                                      stops: const [0.0, 1.0],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          // Top-edge light reflection sheen
                          if (_isHovered && !isMobile)
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              height: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      accent.withValues(alpha: 0.6),
                                      Colors.white.withValues(alpha: 0.8),
                                      accent.withValues(alpha: 0.6),
                                      Colors.transparent,
                                    ],
                                    stops: [
                                      0.0,
                                      math.max(0.0, (currentX + 1) / 2 - 0.25),
                                      ((currentX + 1) / 2).clamp(0.0, 1.0),
                                      math.min(1.0, (currentX + 1) / 2 + 0.25),
                                      1.0,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
