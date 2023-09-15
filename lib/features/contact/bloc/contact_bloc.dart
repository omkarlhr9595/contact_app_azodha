import 'dart:async';

import 'package:contact_app_azodha/features/contact/models/contact.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repos/contact_service.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactService _service = ContactService();
  ContactBloc() : super(ContactInitial()) {
    on<FetchContacts>(fetchContacts);
    on<AddContact>(addContact);
    on<DeleteContact>(deleteContact);
  }

  FutureOr<void> fetchContacts(
    FetchContacts event,
    Emitter<ContactState> emit,
  ) async {
    emit(ContactsLoading());
    try {
      List<Contact> contact = await _service.fetchContacts();
      contact.sort((a, b) => a.name.compareTo(b.name));
      emit(ContactsLoaded(contacts: contact));
    } catch (_) {
      emit(ContactsError());
    }
  }

  FutureOr<void> addContact(
    AddContact event,
    Emitter<ContactState> emit,
  ) async {
    emit(ContactsLoading());
    try {
      await _service.addContact(event.contact);
      List<Contact> updatedcontact = await _service.fetchContacts();
      updatedcontact.sort((a, b) => a.name.compareTo(b.name));
      emit(ContactsLoaded(contacts: updatedcontact));
    } catch (_) {
      emit(ContactsError());
    }
  }

  FutureOr<void> deleteContact(
    DeleteContact event,
    Emitter<ContactState> emit,
  ) async {
    try {
      await _service.deleteContact(event.contactId);
      List<Contact> updatedcontact = await _service.fetchContacts();
      updatedcontact.sort((a, b) => a.name.compareTo(b.name));
      emit(ContactsLoaded(contacts: updatedcontact));
    } catch (_) {
      emit(ContactsError());
    }
  }
}
