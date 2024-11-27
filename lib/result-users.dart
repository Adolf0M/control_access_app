import 'package:flutter/material.dart';
import 'add-users.dart';
import 'scan-qr.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int _selectedIndex = 0;
  final List<Map<String, String>> _users = [];
  final List<bool> _isEditing = [];
  final List<TextEditingController> _nameControllers = [];
  final List<TextEditingController> _lastNameControllers = [];
  final List<TextEditingController> _emailControllers = [];

  static const List<String> _titles = <String>[
    'Resultados',
    'Escáner QR',
    'Agregar Usuario',
  ];

  void _addUser(Map<String, String> user) {
    setState(() {
      _users.add(user);
      _isEditing.add(false);
      _nameControllers.add(TextEditingController(text: user['name']));
      _lastNameControllers.add(TextEditingController(text: user['lastName']));
      _emailControllers.add(TextEditingController(text: user['email']));
      _selectedIndex = 0;
    });
  }

  void _deleteUser(int index) {
    setState(() {
      _users.removeAt(index);
      _isEditing.removeAt(index);
      _nameControllers.removeAt(index);
      _lastNameControllers.removeAt(index);
      _emailControllers.removeAt(index);
    });
  }

  void _toggleEditMode(int index) {
    setState(() {
      _isEditing[index] = !_isEditing[index];
    });
  }

  void _updateUser(int index) {
    setState(() {
      _users[index] = {
        'name': _nameControllers[index].text,
        'lastName': _lastNameControllers[index].text,
        'email': _emailControllers[index].text,
      };
    });
  }

  @override
Widget build(BuildContext context) {
  final List<Widget> _widgetOptions = <Widget>[
    _buildResultView(),
    ScanQrScreen(
      onQRScanned: (String scannedResult) {
        _addUser({
          'name': 'Nombre QR', // Asigna un valor por defecto o úsalo según el formato del QR
          'lastName': 'Apellido QR',
          'email': scannedResult,
        });
      },
    ),
    AddUsersScreen(onUserAdded: _addUser),
  ];

  return Scaffold(
    appBar: AppBar(
      title: Text(_titles[_selectedIndex]),
    ),
    body: _widgetOptions.elementAt(_selectedIndex),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Resultados',
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

  Widget _buildResultView() {
    return _users.isEmpty
        ? const Center(
            child: Text(
              'No hay usuarios agregados.',
              style: TextStyle(fontSize: 18),
            ),
          )
        : ListView.builder(
            itemCount: _users.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: Container(
                        width: double.infinity,
                        color: const Color.fromARGB(255, 202, 182, 1),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'VISITA ${index + 1}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildEditableField(
                            label: 'Nombre',
                            controller: _nameControllers[index],
                            isEditing: _isEditing[index],
                          ),
                          _buildEditableField(
                            label: 'Apellidos',
                            controller: _lastNameControllers[index],
                            isEditing: _isEditing[index],
                          ),
                          _buildEditableField(
                            label: 'Correo',
                            controller: _emailControllers[index],
                            isEditing: _isEditing[index],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(
                                  _isEditing[index] ? Icons.save : Icons.edit,
                                  color: _isEditing[index]
                                      ? Colors.green
                                      : Colors.blue,
                                ),
                                onPressed: () {
                                  if (_isEditing[index]) {
                                    _updateUser(index);
                                  }
                                  _toggleEditMode(index);
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteUser(index),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: isEditing
          ? TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
                border: const OutlineInputBorder(),
              ),
            )
          : Text(
              '$label: ${controller.text}',
              style: const TextStyle(fontSize: 16),
            ),
    );
  }
}
