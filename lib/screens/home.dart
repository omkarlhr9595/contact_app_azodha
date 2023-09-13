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
          openAddContactSheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void openAddContactSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const SizedBox(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('This is bottom sheet'),
              ],
            ),
          ),
        );
      },
    );
  }
}
