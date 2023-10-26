import 'package:flutter/material.dart';
import 'package:my_app/widgets/drawers.dart';


class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ticketify",
        ),
      ),
      body: Center(
        child: Container(
          child: const Text("Welcome to Dashboard"),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}