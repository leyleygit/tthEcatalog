import 'package:ecatalog/components/size_config.dart';
import 'package:flutter/material.dart';

class CustomGradientElevatedButton extends StatefulWidget {
  final List<Color>? listColor;
  final double? width, height;
  final Widget child;
  final VoidCallback onPressed;
  const CustomGradientElevatedButton(
      {super.key,
      required this.child,
      this.width,
      this.height,
      required this.onPressed,
      this.listColor});

  @override
  State<CustomGradientElevatedButton> createState() =>
      _CustomGradientElevatedButtonState();
}

class _CustomGradientElevatedButtonState
    extends State<CustomGradientElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: widget.listColor ??
                  [
                    const Color(0xff35E892),
                    const Color(0xff178461),
                    const Color(0xff318481)
                  ])),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.resolveWith((states) {
            return SizeConfig.kElevationButton;
          }),
          overlayColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.focused) ||
                states.contains(MaterialState.pressed)) {
              return Colors.grey.shade200.withOpacity(.23);
            }

            return Colors.white;
          }),

          minimumSize: MaterialStateProperty.resolveWith(
              (states) => Size(widget.width ?? 100, widget.height ?? 50)),
          // surfaceTintColor:
          //     MaterialStateProperty.resolveWith((states) => Colors.white),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          padding: MaterialStateProperty.resolveWith(
              (states) => const EdgeInsets.only(left: 10, right: 10)),
        ),
        onPressed: widget.onPressed,
        child: widget.child,
      ),
    );
  }
}
