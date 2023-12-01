import 'package:flutter/material.dart';

Widget displayListWidget<T>(String header, List<T> list,
    Widget Function(List<T>) buildListWidget, String? emptyMessage) {
  if (list.isEmpty) {
    return emptyMessage != null
        ? Text(emptyMessage, textAlign: TextAlign.center)
        : const SizedBox.shrink();
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(header,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      buildListWidget(list),
    ],
  );
}
