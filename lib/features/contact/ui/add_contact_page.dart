import 'package:contact_app_azodha/features/contact/models/contact.dart';
import 'package:contact_app_azodha/features/contact/ui/locations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../bloc/contact_bloc.dart';

class AddContactPage extends StatefulWidget {
  final ContactBloc contactBloc;
  const AddContactPage({Key? key, required this.contactBloc}) : super(key: key);

  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  String selectedState = Locations.state[0]; // Default to the first state
  String selectedCity = Locations.cities[0][0];
  final FocusNode firstNameFocus = FocusNode();
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneNumberFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  final FocusNode stateFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();

  @override
  void dispose() {
    firstNameFocus.dispose();
    lastNameFocus.dispose();
    emailFocus.dispose();
    phoneNumberFocus.dispose();
    addressFocus.dispose();
    stateFocus.dispose();
    cityFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String selectedUserState = selectedState;
    String selectedUserCity = selectedCity;
    void saveContact() {
      final firstName = firstNameController.text.trim();
      final lastName = lastNameController.text.trim();
      final email = emailController.text.trim();
      final phoneNumber = phoneNumberController.text.trim();
      final address = addressController.text.trim();
      final state = selectedUserState.trim();
      final city = selectedUserCity.trim();

      if (firstName.isEmpty ||
          lastName.isEmpty ||
          email.isEmpty ||
          phoneNumber.isEmpty ||
          address.isEmpty ||
          city.isEmpty ||
          state.isEmpty) {
        // Show an error message to the user.
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please fill in all required fields."),
        ));
        return;
      }
      String uuid = const Uuid().v4();

      final newContact = Contact(
        id: uuid,
        name: '$firstName $lastName',
        phoneNumber: phoneNumber,
        address: '$address, $city, $state',
        email: email,
      );
      widget.contactBloc.add(AddContact(newContact));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$firstName $lastName saved"),
      ));
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add contact"),
        actions: [
          FilledButton(
            onPressed: () {
              saveContact();
            },
            child: const Text("Save"),
          ),
          const SizedBox(
            width: 24,
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => ContactBloc(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: firstNameController,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    labelText: 'First name',
                  ),
                  focusNode: firstNameFocus,
                  onSubmitted: (value) {
                    FocusScope.of(context).requestFocus(lastNameFocus);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last name',
                  ),
                  focusNode: lastNameFocus,
                  onSubmitted: (value) {
                    FocusScope.of(context).requestFocus(emailFocus);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  focusNode: emailFocus,
                  onSubmitted: (value) {
                    FocusScope.of(context).requestFocus(phoneNumberFocus);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.dialpad),
                    border: OutlineInputBorder(),
                    labelText: 'Phone number',
                  ),
                  focusNode: phoneNumberFocus,
                  onSubmitted: (value) {
                    FocusScope.of(context).requestFocus(addressFocus);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(),
                    labelText: 'Address',
                  ),
                  focusNode: addressFocus,
                  onSubmitted: (value) {
                    FocusScope.of(context).requestFocus(stateFocus);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField<String>(
                  value: selectedState,
                  onChanged: (newValue) {
                    setState(() {
                      selectedState = newValue!;
                      selectedCity = Locations
                          .cities[Locations.state.indexOf(selectedState)][0];
                    });
                  },
                  items: Locations.state.map<DropdownMenuItem<String>>(
                    (String state) {
                      return DropdownMenuItem<String>(
                        value: state,
                        child: Text(state),
                      );
                    },
                  ).toList(),
                  borderRadius: BorderRadius.circular(10.0),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  focusNode: stateFocus,
                  onSaved: (value) {
                    FocusScope.of(context).requestFocus(cityFocus);
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedCity,
                  onChanged: (newValue) {
                    setState(() {
                      selectedCity = newValue!;
                    });
                  },
                  items: Locations
                      .cities[Locations.state.indexOf(selectedState)]
                      .map<DropdownMenuItem<String>>(
                    (String city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      );
                    },
                  ).toList(),
                  borderRadius: BorderRadius.circular(10.0),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
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
