import 'package:contact_app_azodha/features/contact/bloc/contact_bloc.dart';
import 'package:contact_app_azodha/features/contact/ui/add_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ContactBloc contactBloc = ContactBloc();
  @override
  void initState() {
    super.initState();
    contactBloc.add(ContactInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact"),
        //To change the color of System Navigation Bar
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Theme.of(context).colorScheme.background,
        ),
      ),
      body: BlocConsumer<ContactBloc, ContactState>(
        bloc: contactBloc,
        listenWhen: (previous, current) => current is ContactActionState,
        buildWhen: (previous, current) => current is! ContactActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case ContactLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case ContactLoadedSucessState:
              final successState = state as ContactLoadedSucessState;

              if (successState.contacts.isEmpty) {
                return const Center(
                  child: Text("No contacts added"),
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  contactBloc.add(ContactInitialFetchEvent());
                },
                child: ListView.builder(
                  itemCount: successState.contacts.length,
                  itemBuilder: (context, index) {
                    final contact = successState.contacts[index];
                    return ListTile(
                      title: Text(contact.name),
                      subtitle: Text(contact.phoneNumber),
                      // You can add more ListTile properties here, e.g., onTap for interactions
                    );
                  },
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            createRoute(const AddContactPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  //slide to new page on the right instead of the bottom
  Route createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
