import 'package:flutter/material.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("My Addresses"),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFF57C00),
        foregroundColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Add Address coming next"),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Address"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: [

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),

            child: const ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(0xFFF57C00),
                child: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
              ),

              title: Text(
                "Home",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Text(
                "Gwarinpa, Abuja",
              ),

              trailing: Icon(Icons.edit),
            ),
          ),

          const SizedBox(height: 15),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),

            child: const ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.work,
                  color: Colors.white,
                ),
              ),

              title: Text(
                "Office",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Text(
                "Wuse 2, Abuja",
              ),

              trailing: Icon(Icons.edit),
            ),
          ),
        ],
      ),
    );
  }
}