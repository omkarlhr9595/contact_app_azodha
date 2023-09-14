import 'dart:async';

import 'package:contact_app_azodha/features/contact/repos/contact_service.dart';
import 'package:contact_app_azodha/features/contact/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactService _contactService = ContactService();
  ContactBloc() : super(ContactInitial()) {
    on<ContactInitialFetchEvent>(contactInitialFetchEvent);
    on<ContactAddEvent>(contactAddEvent);
  }

  FutureOr<void> contactInitialFetchEvent(
    ContactInitialFetchEvent event,
    Emitter<ContactState> emit,
  ) async {
    final List<Contact> contacts = await _contactService.fetchContacts();
    print("from firebase $contacts");
    emit(ContactLoadedSucessState(contacts: contacts));
  }

  FutureOr<void> contactAddEvent(
    ContactAddEvent event,
    Emitter<ContactState> emit,
  ) async {
    try {
      await _contactService.addContact(event.newContact);
    } catch (e) {
      emit(ContactErrorState(error: 'Failed to add contact: $e'));
    }
  }
}
