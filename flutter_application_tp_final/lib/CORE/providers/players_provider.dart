import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_tp_final/CORE/entities/players.dart';

class PlayerProvider extends ChangeNotifier {
  List<Player> _players = [];

  List<Player> get players => _players;

  final _playersCollection = FirebaseFirestore.instance.collection('player');

  
  Future<void> fetchPlayers() async {
    try {
      final snapshot = await _playersCollection.orderBy('createdAt', descending: true).get();
      _players = snapshot.docs.map((doc) {
        final data = doc.data();
        return Player(
          id: doc.id,
          name: data['name'],
          desc: data['description'],
          urlimag: data['imageUrl'],
        );
      }).toList();
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print('Error al cargar jugadores: $error');
      }
    }
  }

  Future<void> addPlayer(Player player) async {
    try {
      final docRef = await _playersCollection.add({
        'title': player.name,
        'description': player.desc,
        'imageUrl': player.urlimag,
        'createdAt': FieldValue.serverTimestamp(),
      });
      player.id = docRef.id;
      _players.add(player);
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print('Error al agregar jugador: $error');
      }
    }
  }

  Future<void> updatePlayer(String id, String name, String description, String imageUrl) async {
    try {
      await _playersCollection.doc(id).update({
        'name': name,
        'description': description,
        'imageUrl': imageUrl,
      });

      final playerIndex = _players.indexWhere((player) => player.id == id);
      if (playerIndex != -1) {
        _players[playerIndex].name = name;
        _players[playerIndex].desc = description;
        _players[playerIndex].urlimag = imageUrl;
        notifyListeners();
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error al actualizar jugador: $error');
      }
    }
  }


  Future<void> deletePlayer(String id) async {
    try {
      await _playersCollection.doc(id).delete();
      _players.removeWhere((player) => player.id == id);
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print('Error al eliminar jugador: $error');
      }
    }
  }
}
