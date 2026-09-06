import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../theme/app_theme.dart';

/// Cursor display modes
enum CursorMode {
  normal,
  pointer,
  card,
  text,
}

/// Global cursor state controller
class CursorController extends ChangeNotifier {
  CursorMode _mode = CursorMode.normal;
  Color? _accentColor;
  String? _label;

  CursorMode get mode => _mode;
  Color? get accentColor => _accentColor;
  String? get label => _label;

  void setPointer({Color? accentColor}) {
    _mode = CursorMode.pointer;
    _accentColor = accentColor;
    _label = null;
    notifyListeners();
  }

  void setCard({Color? accentColor, String? label}) {
    _mode = CursorMode.card;
    _accentColor = accentColor;
    _label = label;
    notifyListeners();
  }

  void reset() {
    if (_mode != CursorMode.normal || _accentColor != null || _label != null) {
      _mode = CursorMode.normal;
      _accentColor = null;
      _label = null;
      notifyListeners();
    }
  }
}

/// Scope inherited widget for accessing CursorController anywhere in tree
class CursorProvider extends InheritedWidget {
  final CursorController controller;

  const CursorProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  static CursorController? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CursorProvider>()?.controller;
  }

  @override
  bool updateShouldNotify(CursorProvider oldWidget) => controller != oldWidget.controller;
}

/// Helper to wrap any interactive element with custom cursor reaction
class CursorInteractable extends StatelessWidget {
  final Widget child;
  final CursorMode mode;
  final Color? accentColor;
  final String? label;
  final VoidCallback? onTap;

  const CursorInteractable({
    super.key,
    required this.child,
    this.mode = CursorMode.pointer,
    this.accentColor,
    this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        final ctrl = CursorProvider.of(context);
        if (ctrl == null) return;
        if (mode == CursorMode.card) {
          ctrl.setCard(accentColor: accentColor, label: label);
        } else {
          ctrl.setPointer(accentColor: accentColor);
        }
      },
      onExit: (_) {
        CursorProvider.of(context)?.reset();
      },
      child: onTap != null
          ? GestureDetector(onTap: onTap, child: child)
          : child,
    );
  }
}

/// Root widget that tracks pointer and draws the animated cursor
class AnimatedCursor extends StatefulWidget {
  final Widget child;

  const AnimatedCursor({super.key, required this.child});

  @override
  State<AnimatedCursor> createState() => _AnimatedCursorState();
}

class _AnimatedCursorState extends State<AnimatedCursor>
    with SingleTickerProviderStateMixin {
  final CursorController _controller = CursorController();

  Offset _targetPosition = Offset.zero;
  Offset _currentTrailingPosition = Offset.zero;
  bool _isPointerInside = false;
  bool _isPointerDown = false;
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((_) {
      if (!_isPointerInside) return;
      // Spring interpolation for smooth trailing lag (0.22 factor provides silky inertia)
      final dx = _currentTrailingPosition.dx + (_targetPosition.dx - _currentTrailingPosition.dx) * 0.22;
      final dy = _currentTrailingPosition.dy + (_targetPosition.dy - _currentTrailingPosition.dy) * 0.22;
      if (mounted) {
        setState(() {
          _currentTrailingPosition = Offset(dx, dy);
        });
      }
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onPointerHover(PointerEvent event) {
    _targetPosition = event.position;
    if (!_isPointerInside) {
      _currentTrailingPosition = event.position;
      setState(() => _isPointerInside = true);
    }
  }

  void _onPointerDown(PointerDownEvent event) {
    setState(() => _isPointerDown = true);
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() => _isPointerDown = false);
  }

  void _onPointerExit() {
    setState(() => _isPointerInside = false);
  }

  @override
  Widget build(BuildContext context) {
    // Disable on mobile/touch screens or small viewports for native touch performance
    final isTouch = !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS);

    if (isTouch) {
      return widget.child;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return widget.child;
        }

        return CursorProvider(
          controller: _controller,
          child: Listener(
            behavior: HitTestBehavior.translucent,
            onPointerHover: _onPointerHover,
            onPointerDown: _onPointerDown,
            onPointerUp: _onPointerUp,
            child: MouseRegion(
              onExit: (_) => _onPointerExit(),
              child: Stack(
                children: [
                  widget.child,

                  // Custom cursor layer
                  if (_isPointerInside)
                    IgnorePointer(
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, _) {
                          final mode = _controller.mode;
                          final accent = _controller.accentColor ?? AppColors.primaryLight;
                          final label = _controller.label;

                          double outerSize = 34.0;
                          double innerSize = 6.0;
                          Color outerBorderColor = accent.withValues(alpha: 0.6);
                          Color outerFillColor = accent.withValues(alpha: 0.08);

                          if (mode == CursorMode.pointer) {
                            outerSize = 54.0;
                            innerSize = 4.0;
                            outerBorderColor = accent.withValues(alpha: 0.9);
                            outerFillColor = accent.withValues(alpha: 0.16);
                          } else if (mode == CursorMode.card) {
                            outerSize = 68.0;
                            innerSize = 0.0;
                            outerBorderColor = accent.withValues(alpha: 0.95);
                            outerFillColor = accent.withValues(alpha: 0.2);
                          }

                          if (_isPointerDown) {
                            outerSize *= 0.85;
                            innerSize *= 0.85;
                          }

                          return Stack(
                            children: [
                              // Trailing Outer Ring
                              Positioned(
                                left: _currentTrailingPosition.dx - outerSize / 2,
                                top: _currentTrailingPosition.dy - outerSize / 2,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 180),
                                  curve: Curves.easeOutCubic,
                                  width: outerSize,
                                  height: outerSize,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: outerFillColor,
                                    border: Border.all(
                                      color: outerBorderColor,
                                      width: mode == CursorMode.card ? 2.0 : 1.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: accent.withValues(alpha: 0.25),
                                        blurRadius: mode == CursorMode.card ? 16 : 10,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: (label != null && mode == CursorMode.card)
                                      ? Center(
                                          child: Text(
                                            label,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 0.8,
                                            ),
                                          ),
                                        )
                                      : null,
                                ),
                              ),

                              // Pinpoint Inner Dot (Direct target position)
                              if (innerSize > 0)
                                Positioned(
                                  left: _targetPosition.dx - innerSize / 2,
                                  top: _targetPosition.dy - innerSize / 2,
                                  child: Container(
                                    width: innerSize,
                                    height: innerSize,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: accent,
                                          blurRadius: 4,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
