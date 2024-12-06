import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/auth.dart';
import 'add-users.dart';
import 'scan-qr.dart';
import 'result-users.dart'; // Asegúrate de importar correctamente

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Controla el índice del BottomNavigationBar

  // Lista de títulos para cada pantalla
  static const List<String> _titles = <String>[
    'Inicio', // Título para la pantalla Home
    'Escáner - Próxima funcionalidad', // Título para la pantalla de escanear
    'Agregar Usuario', // Título para la pantalla de agregar usuario
  ];

  // Lista de pantallas a mostrar
  List<Widget> _widgetOptions(BuildContext context) => <Widget>[
        ScanQrScreen(
          onQRScanned: (qrData) {
            // Maneja los datos escaneados del QR
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'QR Escaneado: ${qrData["name"]} - ${qrData["email"]}'),
              ),
            );
          },
        ),
        AddUsersScreen(
          onUserAdded: (userData) {
            // Maneja los datos del usuario agregado
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Usuario agregado: ${userData["name"]}')),
            );
          },
        ),
        ResultScreen(), // Agregar la pantalla de resultados
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
      ),
      body: _widgetOptions(context)[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Escáner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Agregar Usuario',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text("Auth");
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text("Sign out"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _userUid(),
            _signOutButton(),
          ],
        ),
      ),
    );
  }
}
