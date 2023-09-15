import 'package:contact_app_azodha/features/contact/bloc/contact_bloc.dart';
import 'package:contact_app_azodha/features/contact/models/contact.dart';
import 'package:flutter/material.dart';

class ViewContactDetailPage extends StatefulWidget {
  final Contact contact;
  final Color color;
  final ContactBloc contactBloc;
  const ViewContactDetailPage({
    Key? key,
    required this.contact,
    required this.color,
    required this.contactBloc,
  }) : super(key: key);

  @override
  State<ViewContactDetailPage> createState() => _ViewContactDetailPageState();
}

class _ViewContactDetailPageState extends State<ViewContactDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        GestureDetector(
            onTap: () {
              widget.contactBloc.add(DeleteContact(widget.contact.id));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Contact deleted"),
              ));
              Navigator.pop(context);
            },
            child: const Icon(Icons.delete)),
        const SizedBox(
          width: 24,
        )
      ]),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100,
                backgroundColor: widget.color,
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.background,
                  size: 100,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                widget.contact.name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 32),
              ),
              Text(
                widget.contact.phoneNumber,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                widget.contact.email,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                widget.contact.address,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
