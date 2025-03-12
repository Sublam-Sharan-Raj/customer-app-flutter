import 'package:flutter/material.dart';
import 'package:insta_closet/models/setting.dart';

class AppSettingsWidget extends StatefulWidget {
  const AppSettingsWidget({super.key});

  @override
  _AppSettingsWidgetState createState() => _AppSettingsWidgetState();
}

class _AppSettingsWidgetState extends State<AppSettingsWidget> {
  List<Setting> settings = [
    Setting(
        title: "Enable Notifications",
        description: "Receive app notifications",
        isSwitch: true,
        value: true),
    Setting(
        title: "Change Language",
        description: "Select app language",
        value: "English"),
    Setting(
        title: "Privacy Policy",
        description: "Review privacy policy",
        isSwitch: false,
        value: null),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App Settings')),
      body: ListView.builder(
        itemCount: settings.length,
        itemBuilder: (context, index) {
          final setting = settings[index];

          return ListTile(
            title: Text(setting.title),
            subtitle: Text(setting.description),
            trailing: setting.isSwitch
                ? Switch(
                    value: setting.value,
                    onChanged: (bool newValue) {
                      setState(() {
                        setting.value = newValue;
                      });
                    },
                  )
                : setting.value == null
                    ? IconButton(
                        icon: Icon(Icons.info_outline),
                        onPressed: () {
                          // Handle privacy policy or other actions
                        },
                      )
                    : Text(setting.value),
            onTap: () {
              if (!setting.isSwitch) {
                _showEditDialog(setting);
              }
            },
          );
        },
      ),
    );
  }

  // Show dialog to edit settings
  _showEditDialog(Setting setting) {
    TextEditingController controller =
        TextEditingController(text: setting.value);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit ${setting.title}'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: setting.title,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  setting.value = controller.text;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
