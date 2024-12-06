import 'dart:convert'; // Para manejar JSON
import 'package:http/http.dart' as http;

Future<void> sendPostRequest(Map<String, dynamic> data) async {
  const String url = 'https://example.com/api/posts'; // Reemplaza con tu URL
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'}, // Encabezados
      body: json.encode(data), // Datos codificados en JSON
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Datos enviados con éxito: ${response.body}');
    } else {
      print('Error al enviar datos: ${response.statusCode}');
      print('Respuesta: ${response.body}');
    }
  } catch (error) {
    print('Error: $error');
  }
}
