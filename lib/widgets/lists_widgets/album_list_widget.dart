import 'package:flutter/material.dart';
import 'package:media_recommender/models/album.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AlbumListWidget extends StatelessWidget {
  final List<Album> album;

  const AlbumListWidget({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: album.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            album[index].name,
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(album[index].artist),
          onTap: () async {
            final url = album[index].href;
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
