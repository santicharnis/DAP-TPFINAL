import 'package:flutter/material.dart';
import 'package:flutter_application_tp_final/CORE/entities/players.dart';
import 'package:flutter_application_tp_final/CORE/providers/players_provider.dart';
import 'package:provider/provider.dart';

class EditPlayerScreen extends StatefulWidget {
  final Player player;

  const EditPlayerScreen({super.key, required this.player});

  @override
  _EditPlayerScreenState createState() => _EditPlayerScreenState();
}

class _EditPlayerScreenState extends State<EditPlayerScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _description;
  late String _imageUrl;

  @override
  void initState() {
    super.initState();
    _name = widget.player.name;
    _description = widget.player.desc;
    _imageUrl = widget.player.urlimag;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Película')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              initialValue: _name,
              decoration: const InputDecoration(labelText: 'Nombre'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un nombre';
                }
                return null;
              },
              onSaved: (value) => _name = value!,
            ),
            TextFormField(
              initialValue: _description,
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
              initialValue: _imageUrl,
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
              child: const Text('Actualizar Película'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final playerProvider = Provider.of<PlayerProvider>(context, listen: false);
                  playerProvider.updatePlayer(
                    widget.player.id,
                    _name,
                    _description,
                    _imageUrl,
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Pelicula actualizada', style: TextStyle(fontSize: 20)),
                  backgroundColor: Color.fromARGB(255, 0, 255, 0),
                ));
                
                } else {
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Por favor, rellenar campos vacios', style: TextStyle(fontSize: 20)),
                  backgroundColor: Color.fromARGB(255, 255, 0, 0),
                ));
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Eliminar Película'),
              onPressed: () {
                final playerProvider = Provider.of<PlayerProvider>(context, listen: false);
                playerProvider.deletePlayer(widget.player.id);
                Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Pelicula eliminada', style: TextStyle(fontSize: 20)),
                  backgroundColor: Color.fromARGB(255, 255, 0, 0),
                ));
                
              },
            ),
          ],
        ),
      ),
    );
  }
}