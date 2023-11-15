import 'package:flutter/material.dart';
import 'package:media_recommender/models/artist.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ArtistListWidget extends StatelessWidget {
  final List<Artist> artist;

  const ArtistListWidget({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: artist.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            artist[index].name,
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: null,
          onTap: () async {
            final url = artist[index].href;
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
