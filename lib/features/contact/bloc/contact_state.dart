part of 'contact_bloc.dart';

@immutable
sealed class ContactState {}

abstract class ContactActionState extends ContactState {}

final class ContactInitial extends ContactState {}

final class ContactLoadingState extends ContactState {}

final class ContactLoadedSucessState extends ContactState {
  final List<Contact> contacts;

  ContactLoadedSucessState({required this.contacts});
}

final class ContactErrorState extends ContactState {
  final String error;

  ContactErrorState({required this.error});
}
