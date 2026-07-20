import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool notifications = true;
  bool darkMode = false;
  bool location = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: [

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),

            child: SwitchListTile(
              value: notifications,

              onChanged: (value){
                setState(() {
                  notifications = value;
                });
              },

              secondary: const Icon(
                Icons.notifications,
                color: Color(0xFFF57C00),
              ),

              title: const Text("Push Notifications"),
            ),
          ),

          const SizedBox(height: 15),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),

            child: SwitchListTile(
              value: location,

              onChanged: (value){
                setState(() {
                  location = value;
                });
              },

              secondary: const Icon(
                Icons.location_on,
                color: Color(0xFFF57C00),
              ),

              title: const Text("Location Services"),
            ),
          ),

          const SizedBox(height: 15),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),

            child: SwitchListTile(
              value: darkMode,

              onChanged: (value){
                setState(() {
                  darkMode = value;
                });
              },

              secondary: const Icon(
                Icons.dark_mode,
                color: Color(0xFFF57C00),
              ),

              title: const Text("Dark Mode"),
            ),
          ),

          const SizedBox(height: 25),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.info,
                color: Color(0xFFF57C00),
              ),

              title: const Text("About Bellewise"),

              trailing: const Icon(Icons.chevron_right),
            ),
          ),

          const SizedBox(height: 15),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),

              title: const Text(
                "Delete Account",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),

              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
    );
  }
}