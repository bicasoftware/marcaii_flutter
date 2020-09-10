import 'package:flutter/material.dart';
import 'package:marcaii_flutter/strings.dart';

class ErrorTextAnim extends StatefulWidget {
  const ErrorTextAnim(this.errorText, {Key key}) : super(key: key);
  final String errorText;
  @override
  _ErrorTextAnimState createState() => _ErrorTextAnimState();
}

class _ErrorTextAnimState extends State<ErrorTextAnim> with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Consts.animationDuration);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          widget.errorText,
          style: Theme.of(context).textTheme.caption.copyWith(color: Colors.red),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
