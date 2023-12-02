import 'package:flutter/material.dart';
import 'package:media_recommender/models/playlist.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PlaylistListWidget extends StatelessWidget {
  final List<Playlist> playlist;

  const PlaylistListWidget({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: playlist.length,
      itemBuilder: (context, index) {
        final playlistItem = playlist[index];
        return ListTile(
          title: Text(
            playlistItem.name,
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                playlistItem.description,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          onTap: () async {
            final url = playlistItem.href;
            if (await canLaunchUrlString(url)) {
              await launchUrlString(url);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Could not launch URL')),
              );
            }
          },
        );
      },
    );
  }
}
