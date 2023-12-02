import 'package:flutter/material.dart';
import 'package:media_recommender/models/show.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ShowListWidget extends StatelessWidget {
  final List<Show> show;

  const ShowListWidget({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: show.length,
      itemBuilder: (context, index) {
        final showItem = show[index];
        return ListTile(
          title: Text(
            showItem.name,
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                showItem.description,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          onTap: () async {
            final url = showItem.href;
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
