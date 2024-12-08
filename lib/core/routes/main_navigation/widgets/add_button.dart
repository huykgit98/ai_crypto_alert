import 'package:ai_crypto_alert/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddButton extends StatefulWidget {
  final Function onTap;
  final bool inverted;

  const AddButton({
    Key? key,
    required this.onTap,
    required this.inverted,
  }) : super(key: key);

  @override
  State<AddButton> createState() => _PostVideoButtonState();
}

class _PostVideoButtonState extends State<AddButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
      lowerBound: 0.0,
      upperBound: 0.2,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 + _controller.value;
    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      child: Transform.scale(
        scale: _scale,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: 20,
              child: Container(
                height: 30,
                width: 25,
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.p8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff61D4F0),
                  borderRadius: BorderRadius.circular(
                    Sizes.p8,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20,
              child: Container(
                height: 30,
                width: 25,
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.p8,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(
                    Sizes.p8,
                  ),
                ),
              ),
            ),
            Container(
              height: 30,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.p8,
              ),
              decoration: BoxDecoration(
                color: !widget.inverted ? Colors.white : Colors.black,
                borderRadius: BorderRadius.circular(
                  Sizes.p8,
                ),
              ),
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.plus,
                  color: !widget.inverted ? Colors.black : Colors.white,
                  size: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
