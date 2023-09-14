import 'package:contact_app_azodha/features/contact/bloc/contact_bloc.dart';
import 'package:contact_app_azodha/features/contact/models/contact.dart';
import 'package:contact_app_azodha/features/contact/repos/contact_service.dart';
import 'package:flutter/material.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final ContactService _contactService = ContactService();
  final ContactBloc _contactBloc = ContactBloc();

  @override
  Widget build(BuildContext context) {
    final TextEditingController _firstNameController = TextEditingController();
    final TextEditingController _lastNameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _phoneNumberController =
        TextEditingController();
    final TextEditingController _addressController = TextEditingController();
    final TextEditingController _cityController = TextEditingController();
    final TextEditingController _stateController = TextEditingController();

    void _saveContact() {
      final firstName = _firstNameController.text;
      final lastName = _lastNameController.text;
      final email = _emailController.text;
      final phoneNumber = _phoneNumberController.text;
      final address = _addressController.text;
      final city = _cityController.text;
      final state = _stateController.text;

      // Create a new Contact object with the entered data.
      final newContact = Contact(
        id: '', // You can generate a unique ID or leave it empty to let Firestore generate one.
        name: '$firstName $lastName',
        phoneNumber: phoneNumber,
        address: '$address, $city, $state',
        email: email,
      );

      // Dispatch an AddContactEvent to add the contact to Firestore.
      _contactBloc.add(ContactAddEvent(newContact: newContact));
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Add contact"),
        actions: [
          FilledButton(
            onPressed: () {
              _saveContact();
            },
            child: const Text("Save"),
          ),
          const SizedBox(
            width: 24,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    labelText: 'First name',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last name',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.dialpad),
                    border: OutlineInputBorder(),
                    labelText: 'Phone number',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(),
                    labelText: 'Address',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'City',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: _stateController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'State',
                  ),
                ),
                const SizedBox(
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
