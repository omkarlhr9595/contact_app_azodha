part of 'contact_bloc.dart';

@immutable
sealed class ContactEvent {}

class ContactInitialFetchEvent extends ContactEvent {}

class ContactAddEvent extends ContactEvent {
  final Contact newContact;

  ContactAddEvent({required this.newContact});
}

class ContactDeleteEvent extends ContactEvent {}
