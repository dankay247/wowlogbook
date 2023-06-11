import 'package:flutter/material.dart';

class AnimatedCircleContainer extends StatefulWidget {
  const AnimatedCircleContainer({Key? key}) : super(key: key);

  @override
  _AnimatedCircleContainerState createState() =>
      _AnimatedCircleContainerState();

  static Animation<Offset>? getAnimation(BuildContext context) {
    final state =
    context.findAncestorStateOfType<_AnimatedCircleContainerState>();
    return state?._animation;
  }
}


class _AnimatedCircleContainerState extends State<AnimatedCircleContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<Offset>(
      begin: const Offset(0.2, 0.2),
      end: const Offset(0.5, 0.5), // Modify the end value to (0.5, 0.5)
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _controller.forward();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return ClipRect(
          child: Align(
            alignment: Alignment.bottomRight,
            child: FractionalTranslation(
              translation: _animation.value,
              child: Container(
                height: 1000,
                width: 1000,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(255, 255, 255, 0.2),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
