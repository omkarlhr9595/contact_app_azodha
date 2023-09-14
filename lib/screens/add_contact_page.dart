import 'package:flutter/material.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Add contact"),
        actions: [
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.check),
            label: const Text("Save"),
          ),
          const SizedBox(
            width: 24,
          )
        ],
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    labelText: 'First name',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last name',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.dialpad),
                    border: OutlineInputBorder(),
                    labelText: 'Phone number',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(),
                    labelText: 'Address',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'City',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'State',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
