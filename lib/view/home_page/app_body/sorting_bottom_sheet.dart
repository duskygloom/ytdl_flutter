import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class SortingBottomSheet extends StatelessWidget {
  const SortingBottomSheet({super.key, required this.animController});

  final AnimationController animController;

  static const sortingOptions = {
    'Recents': true,
    'Recently added': false,
    'Alphabetical': false,
    'Creator': false,
  };

  @override
  Widget build(BuildContext context) {
    final sortingKeys = sortingOptions.keys.toList();
    final sortingValues = sortingOptions.values.toList();
    return BottomSheet(
      onClosing: () {},
      enableDrag: true,
      showDragHandle: true,
      animationController: animController,
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          children:
              <Widget>[
                ListTile(title: Text('Sort by', textAlign: TextAlign.center)),
                Divider(indent: 10, endIndent: 10),
              ] +
              List.generate(sortingOptions.length, (index) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: ListTile(
                      title: Text(sortingKeys[index]),
                      trailing: sortingValues[index]
                          ? Icon(Symbols.check, color: Colors.green)
                          : null,
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
