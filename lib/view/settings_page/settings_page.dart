import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:ytdl/model/config.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final config = Config.fromContext(context);
    const settingsHint = [
      'API URL',
      'Result count',
      'Audio quality',
      'Audio extension',
      'Video quality',
      'Video extension',
    ];
    const settingsKeyType = [
      TextInputType.url,
      TextInputType.number,
      TextInputType.text,
      TextInputType.text,
      TextInputType.text,
      TextInputType.text,
    ];
    final controllers = [
      TextEditingController(text: config.apiUrl),
      TextEditingController(text: config.resultCount.toString()),
      TextEditingController(text: config.audioQlt),
      TextEditingController(text: config.audioExt),
      TextEditingController(text: config.videoQlt),
      TextEditingController(text: config.videoExt),
    ];
    final validators = [
      null,
      (String? s) {
        if (s == null) {
          return 'Cannot be null';
        } else {
          int i = int.tryParse(s) ?? 0;
          if (i <= 0) return 'Must be a number > 0';
        }
      },
      (String? s) {
        if (s == null) {
          return 'Cannot be null';
        } else {
          const audioQualities = ['none', 'best', 'worst'];
          if (!audioQualities.contains(s)) {
            return 'Possible values: ${audioQualities.join(', ')}';
          }
        }
      },
      (String? s) {
        if (s == null) {
          return 'Cannot be null';
        } else {
          const audioExts = ['m4a'];
          if (!audioExts.contains(s)) {
            return 'Possible values: ${audioExts.join(', ')}';
          }
        }
      },
      (String? s) {
        if (s == null) {
          return 'Cannot be null';
        } else {
          const videoQualities = ['none', 'best', 'worst'];
          if (!videoQualities.contains(s)) {
            return 'Possible values: ${videoQualities.join(', ')}';
          }
        }
      },
      (String? s) {
        if (s == null) {
          return 'Cannot be null';
        } else {
          const videoExts = ['mp4'];
          if (!videoExts.contains(s)) {
            return 'Possible values: ${videoExts.join(', ')}';
          }
        }
      },
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              if (!formKey.currentState!.validate()) return;
              final config = Config.fromContext(context, listen: false);
              config.apiUrl = controllers[0].text;
              config.resultCount = int.parse(controllers[1].text);
              Navigator.pop(context);
            },
            icon: Icon(Symbols.check),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView.separated(
            itemCount: settingsHint.length,
            itemBuilder: (context, index) => TextFormField(
              decoration: InputDecoration(
                hintText: settingsHint[index],
                filled: true,
              ),
              keyboardType: settingsKeyType[index],
              controller: controllers[index],
              validator: validators[index],
            ),
            separatorBuilder: (context, index) => SizedBox(height: 10),
          ),
        ),
      ),
    );
  }
}
