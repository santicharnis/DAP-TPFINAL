import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_tp_final/CORE/entities/players.dart';
import 'package:flutter_application_tp_final/CORE/providers/players_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AddPlayerScreen(),
    );
  }
}

class AddPlayerScreen extends StatefulWidget {
  const AddPlayerScreen({super.key});

  @override
  _AddPlayerScreenState createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends State<AddPlayerScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar jugador')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'nombre'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un nombre';
                }
                return null;
              },
              onSaved: (value) => _title = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Descripción'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una descripción';
                }
                return null;
              },
              onSaved: (value) => _description = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'URL de la imagen'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una URL de imagen';
                }
                return null;
              },
              onSaved: (value) => _imageUrl = value!,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Guardar Película'),
              onPressed: () async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    final player = Player(
      id: '', 
      name: _title,
      desc: _description,
      urlimag: _imageUrl,
    );

    final playerProvider = Provider.of<PlayerProvider>(context, listen: false);
    await playerProvider.addPlayer(player);

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Película guardada', style: TextStyle(fontSize: 20)),
      backgroundColor: Color.fromARGB(255, 0, 255, 0),
    ));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Por favor, rellene los campos',
          style: TextStyle(fontSize: 20)),
      backgroundColor: Color.fromARGB(255, 255, 0, 0),
    ));
  }
}
,
            ),
          ],
        ),
      ),
    );
  }
}
