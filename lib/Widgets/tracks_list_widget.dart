import 'package:flutter/material.dart';
import 'package:media_recommender/models/track.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TrackListWidget extends StatelessWidget {
  final List<Track> tracks;

  const TrackListWidget({super.key, required this.tracks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            tracks[index].name,
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(tracks[index].artist),
          onTap: () async {
            final url = tracks[index].href;
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
