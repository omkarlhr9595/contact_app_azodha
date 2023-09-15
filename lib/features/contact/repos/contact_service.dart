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

  Future<void> deleteContact(String id) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('contacts')
          .where('id', isEqualTo: id)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final contactDoc = querySnapshot.docs.first;
        await contactDoc.reference.delete();
      } else {
        print("Contact with ID $id does not exist.");
        // You can handle this case as needed
      }
    } catch (e) {
      throw Exception('Failed to delete contact: $e');
    }
  }
}
