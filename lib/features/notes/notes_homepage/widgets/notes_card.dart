import 'package:flutter/material.dart';

class NotesCard extends StatelessWidget {
  final String note;
  const NotesCard({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [Text(note)],
        ),
      ),
    );
  }
}
