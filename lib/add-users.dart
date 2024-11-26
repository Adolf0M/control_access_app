import 'package:flutter/material.dart';

class AddUsersScreen extends StatelessWidget {
  const AddUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Agregar Usuario'),
      ),
      body: const Center(
        child: Text(
          'Pantalla para agregar nuevos usuarios',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
