import 'package:flutter/material.dart';
import 'package:flutter_application_tp_final/CORE/SCREEN/edit_players_screen.dart';
import 'package:flutter_application_tp_final/CORE/providers/players_provider.dart';
import 'package:provider/provider.dart';
import 'add_players_screen.dart';


class PlayerListScreen extends StatelessWidget {
  const PlayerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final playerProvider = Provider.of<PlayerProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de jugadores')),
      body: FutureBuilder(
        future: playerProvider.fetchPlayers(),
        builder: (context, snapshot) {

          return ListView.builder(
            itemCount: playerProvider.players.length,
            itemBuilder: (context, index) {
              final player = playerProvider.players[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: InkWell(
                onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditPlayerScreen(player: player),
                      ),
                    );
                  },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(4),
                      ),
                      child: Image.network(
                        player.urlimag,
                        width: 100,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              player.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              player.desc,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPlayerScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
