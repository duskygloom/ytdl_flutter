import 'package:flutter/material.dart';
import 'package:ytdl/view/home_page/app_body/sorting_bottom_sheet.dart';
import 'package:ytdl/view/core_view/toggle_icon_button.dart';

class TweakDisplayRow extends StatefulWidget {
  const TweakDisplayRow({super.key});

  @override
  State<TweakDisplayRow> createState() => _TweakDisplayRowState();
}

class _TweakDisplayRowState extends State<TweakDisplayRow>
    with TickerProviderStateMixin {
  late AnimationController animController;

  @override
  void initState() {
    super.initState();
    animController = BottomSheet.createAnimationController(this)
      ..duration = Duration(seconds: 2);
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SortingBottomSheet(animController: animController);
                },
              );
            },
            icon: Icon(Icons.swap_vert),
            label: Text('Sort'),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.transparent),
            ),
          ),
          ToggleIconButton(
            onPressed: () {},
            iconTrue: Icon(Icons.grid_on),
            iconFalse: Icon(Icons.list),
            state: true,
          ),
        ],
      ),
    );
  }
}
