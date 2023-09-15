import 'dart:math';

import 'package:contact_app_azodha/features/contact/bloc/contact_bloc.dart';
import 'package:contact_app_azodha/features/contact/ui/add_contact_page.dart';
import 'package:contact_app_azodha/features/contact/ui/view_contact_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ContactBloc contactBloc = ContactBloc();
  @override
  void initState() {
    super.initState();
    contactBloc.add(FetchContacts());
  }

  @override
  Widget build(BuildContext context) {
    List<Color> randomColors = [
      Colors.yellow,
      Colors.red,
      Colors.purple,
      Colors.orange,
      Colors.green,
      // Colors.pink,
    ];
    Future<void> refreshContacts() async {
      contactBloc.add(FetchContacts());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact"),
        //To change the color of System Navigation Bar
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Theme.of(context).colorScheme.background,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refreshContacts,
        child: BlocConsumer<ContactBloc, ContactState>(
          bloc: contactBloc,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case ContactsLoading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ContactsLoaded:
                final successState = state as ContactsLoaded;

                if (successState.contacts.isEmpty) {
                  return const Center(
                    child: Text("No contacts added"),
                  );
                }

                return ListView.builder(
                  itemCount: successState.contacts.length,
                  itemBuilder: (context, index) {
                    int randomNumber = Random().nextInt(randomColors.length);
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          createRoute(
                            ViewContactDetailPage(
                              contact: successState.contacts[index],
                              color: randomColors[randomNumber],
                              contactBloc: contactBloc,
                            ),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundColor: randomColors[randomNumber],
                        child: Text(
                          successState.contacts[index].name[0].toUpperCase(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.background,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      title: Text(successState.contacts[index].name),
                    );
                  },
                );
              case ContactsError:
                return const Center(
                  child: Text("Error while fetching contacts"),
                );
              default:
                return const Center(
                  child: Text("Error while fetching contacts"),
                );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            createRoute(
              AddContactPage(
                contactBloc: contactBloc,
              ),
            ),
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
