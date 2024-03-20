import 'package:flutter/material.dart';

class HorizontalFadeTransition extends StatefulWidget {
  final Widget child;
  final bool? fromRight;
  final bool? delayed;
  const HorizontalFadeTransition(
      {super.key, required this.child, this.fromRight, this.delayed});

  @override
  _HorizontalFadeTransitionState createState() =>
      _HorizontalFadeTransitionState();
}

class _HorizontalFadeTransitionState extends State<HorizontalFadeTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> translateAnimation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    translateAnimation = Tween<Offset>(
            begin: Offset(
              widget.fromRight ?? false ? 4 : -4,
              0,
            ),
            end: Offset.zero)
        .animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.fastEaseInToSlowEaseOut,
      ),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.ease,
      ),
    );
    if (widget.delayed ?? false) {
      Future.delayed(const Duration(milliseconds: 150)).then((value) {
          controller.forward();
       
      });
    } else {
      controller.forward();
    }
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: translateAnimation,
        child: widget.child,
      ),
    );
  }
}
