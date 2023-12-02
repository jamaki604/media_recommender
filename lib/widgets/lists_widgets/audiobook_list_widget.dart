import 'package:flutter/material.dart';
import 'package:media_recommender/models/audiobook.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AudiobookListWidget extends StatelessWidget {
  final List<Audiobook> audiobook;

  const AudiobookListWidget({super.key, required this.audiobook});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: audiobook.length,
      itemBuilder: (context, index) {
        final audiobookItem = audiobook[index];
        return ListTile(
          title: Text(
            audiobookItem.name,
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "${audiobookItem.author}\n${audiobookItem.description}",
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          onTap: () async {
            final url = audiobookItem.href;
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
