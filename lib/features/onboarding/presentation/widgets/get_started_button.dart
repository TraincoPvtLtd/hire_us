import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';

class GetStartedButton extends StatefulWidget {
  final VoidCallback onSlideComplete;
  final String label;

  const GetStartedButton({
    super.key,
    required this.onSlideComplete,
    this.label = 'Get Started',
  });

  @override
  State<GetStartedButton> createState() => _GetStartedButtonState();
}

class _GetStartedButtonState extends State<GetStartedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;

  double _dragOffset = 0.0;
  double _animStartOffset = 0.0;
  double _animTargetOffset = 0.0;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    )..addListener(() {
      setState(() {
        final t = Curves.easeOutCubic.transform(_animController.value);
        _dragOffset =
            _animStartOffset + (_animTargetOffset - _animStartOffset) * t;
      });
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _animateTo(double target, {VoidCallback? onEnd}) {
    _animStartOffset = _dragOffset;
    _animTargetOffset = target;
    _animController.reset();
    _animController.forward().then((_) {
      if (mounted && onEnd != null) {
        onEnd();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const double buttonHeight = 62.0;
    const double radius = buttonHeight / 2;
    const double padding = 7.0;
    const double circleSize = buttonHeight - (padding * 2);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double totalWidth = constraints.maxWidth;
        final double maxDragDistance =
        (totalWidth - buttonHeight).clamp(1.0, totalWidth);
        final double progress =
        (_dragOffset / maxDragDistance).clamp(0.0, 1.0);


        final double textOpacity = (1.0 - (progress * 1.4)).clamp(0.0, 1.0);

        return Container(
          height: buttonHeight,
          width: totalWidth,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(radius),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [

              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: buttonHeight + _dragOffset,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                ),
              ),


              IgnorePointer(
                child: Opacity(
                  opacity: textOpacity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text(
                      widget.label,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
              ),


              Positioned(
                left: _dragOffset,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onHorizontalDragStart: (_) {
                    if (_isCompleted) return;
                    _animController.stop();
                  },
                  onHorizontalDragUpdate: (details) {
                    if (_isCompleted) return;
                    setState(() {
                      _dragOffset = (_dragOffset + details.delta.dx)
                          .clamp(0.0, maxDragDistance);
                    });
                  },
                  onHorizontalDragEnd: (details) {
                    if (_isCompleted) return;
                    final double velocity = details.primaryVelocity ?? 0.0;


                    if (_dragOffset >= maxDragDistance * 0.75 ||
                        velocity > 350) {
                      _isCompleted = true;
                      HapticFeedback.mediumImpact();
                      _animateTo(
                        maxDragDistance,
                        onEnd: () {
                          widget.onSlideComplete();

                          Future.delayed(
                            const Duration(milliseconds: 500),
                                () {
                              if (mounted) {
                                _isCompleted = false;
                                _animateTo(0.0);
                              }
                            },
                          );
                        },
                      );
                    } else {

                      _animateTo(0.0);
                    }
                  },
                  onHorizontalDragCancel: () {
                    if (!_isCompleted) {
                      _animateTo(0.0);
                    }
                  },
                  child: SizedBox(
                    width: buttonHeight,
                    height: buttonHeight,
                    child: Center(
                      child: Container(
                        width: circleSize,
                        height: circleSize,
                        decoration: const BoxDecoration(
                          color: AppColors.surface,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isCompleted
                              ? Icons.check_rounded
                              : Icons.chevron_right_rounded,
                          color: AppColors.primary,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}