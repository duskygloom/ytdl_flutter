import 'package:flutter/material.dart';

/// @description
/// If [state] is true, then [iconTrue] is displayed.
/// If [state] is false, then [iconFalse] is displayed.
class ToggleIconButton extends StatefulWidget {
  const ToggleIconButton({
    super.key,
    required this.onPressed,
    required this.iconTrue,
    required this.iconFalse,
    required this.state,
  });

  final void Function() onPressed;
  final Icon iconTrue;
  final Icon iconFalse;
  final bool state;

  @override
  State<ToggleIconButton> createState() => _ToggleIconButtonState();
}

class _ToggleIconButtonState extends State<ToggleIconButton> {
  late bool state;

  @override
  void initState() {
    super.initState();
    state = widget.state;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        widget.onPressed();
        setState(() {
          state = !state;
        });
      },
      icon: state ? widget.iconTrue : widget.iconFalse,
    );
  }
}
