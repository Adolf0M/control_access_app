import 'package:flutter/material.dart';
import 'add-users.dart'; // Asegúrate de importar la pantalla de agregar usuarios.

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
    'Escáner - Próxima funcionalidad',  // Título para la pantalla de escanear
    'Agregar Usuario', // Título para la pantalla de agregar usuario
  ];

  // Lista de pantallas a mostrar
  static const List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Text(
        'Inicio',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
    Center(
      child: Text(
        'Escáner - Próxima funcionalidad',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
    AddUsersScreen(), // Redirige a la pantalla de agregar usuarios
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
        title: Text(_titles[_selectedIndex]), // Muestra el título correspondiente
      ),
      body: _widgetOptions.elementAt(_selectedIndex), // Muestra la pantalla correspondiente
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Selección actual
        onTap: _onItemTapped, // Llama a la función cuando se selecciona un ítem
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Escanear',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Usuarios',
          ),
        ],
      ),
    );
  }
}
