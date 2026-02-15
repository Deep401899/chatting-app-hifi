import 'package:flutter/material.dart';

import '../models/chat_model.dart';
import '../widgets/chat_item.dart';
import 'chat_detail_screen.dart';

class ArchivedScreen extends StatelessWidget {
  final List<Chat> chats;

  const ArchivedScreen({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Archived'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info Text
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: const Text(
              'These chats stay archived when new messages are received. Tap to change',
              style: TextStyle(color: Colors.grey),
            ),
          ),

          // Archived Chats
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ChatItem(
                  chat: chat,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatDetailScreen(chat: chat),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}