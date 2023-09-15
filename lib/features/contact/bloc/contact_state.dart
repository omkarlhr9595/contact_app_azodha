part of 'contact_bloc.dart';

sealed class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

abstract class ContactActionState extends ContactState {}

final class ContactInitial extends ContactState {}

class ContactsLoading extends ContactState {}

class ContactsLoaded extends ContactState {
  final List<Contact> contacts;

  const ContactsLoaded({required this.contacts});

  @override
  List<Object> get props => [contacts];
}

class ContactsError extends ContactState {}
