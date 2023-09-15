part of 'contact_bloc.dart';

sealed class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class FetchContacts extends ContactEvent {}

class AddContact extends ContactEvent {
  final Contact contact;

  const AddContact(this.contact);

  @override
  List<Object> get props => [contact];
}

class DeleteContact extends ContactEvent {
  final String contactId;

  const DeleteContact(this.contactId);

  @override
  List<Object> get props => [contactId];
}
