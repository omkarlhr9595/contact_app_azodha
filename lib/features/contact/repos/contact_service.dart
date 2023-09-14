import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_app_azodha/features/contact/models/contact.dart';

class ContactService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Contact>> fetchContacts() async {
    final QuerySnapshot querySnapshot =
        await _firestore.collection('contacts').get();

    final List<Contact> contacts = querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Contact.fromMap(data);
    }).toList();

    return contacts;
  }

  Future<void> addContact(Contact contact) async {
    try {
      await _firestore.collection('contacts').add(contact.toMap());
    } catch (e) {
      // Handle any errors that occur during contact addition.
      throw Exception('Failed to add contact: $e');
    }
  }
}
