import 'package:contact_app_azodha/screens/add_contact_page.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact"),
      ),
      body: const Center(
        child: Text("Your Contacts"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddContactPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
