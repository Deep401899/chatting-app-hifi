import 'package:flutter/material.dart';

import '../models/chat_model.dart';
import '../utils/constants.dart';

class ChatDetailScreen extends StatefulWidget {
  final Chat chat;

  const ChatDetailScreen({super.key, required this.chat});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() {
    _messages.addAll([
      Message(
        id: '1',
        senderId: 'other',
        senderName: widget.chat.name,
        content: 'Hello! How are you?',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        isSent: true,
        isRead: true,
      ),
      Message(
        id: '2',
        senderId: 'me',
        senderName: 'Me',
        content: 'I\'m good, thanks! How about you?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
        isSent: true,
        isDelivered: true,
        isRead: true,
      ),
      Message(
        id: '3',
        senderId: 'other',
        senderName: widget.chat.name,
        content: 'Doing great! Working on a new project.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        isSent: true,
        isRead: true,
      ),
      Message(
        id: '4',
        senderId: 'me',
        senderName: 'Me',
        content: 'That sounds exciting! Tell me more about it.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        isSent: true,
        isDelivered: true,
        isRead: false,
      ),
    ]);
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final newMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'me',
      senderName: 'Me',
      content: _messageController.text,
      timestamp: DateTime.now(),
      isSent: true,
      isDelivered: false,
      isRead: false,
    );

    setState(() {
      _messages.add(newMessage);
    });

    _messageController.clear();

    // Scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    // Simulate reply after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      final replyMessage = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderId: 'other',
        senderName: widget.chat.name,
        content: 'Thanks! I\'ll share details soon.',
        timestamp: DateTime.now().add(const Duration(seconds: 1)),
        isSent: true,
        isRead: true,
      );

      setState(() {
        _messages.add(replyMessage);
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.chat.name,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              widget.chat.isOnline ? 'online' : 'last seen today at 12:30',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            onSelected: (value) {},
            itemBuilder: (BuildContext context) {
              return [
                'View contact',
                'Media, links and docs',
                'Search',
                'Mute notifications',
                'Wallpaper',
                'More'
              ].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/chat_background.png'), // Add your own
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Messages List
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(8.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isMe = message.senderId == 'me';

                  return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      child: Card(
                        color: isMe ? AppColors.lightGreen : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!isMe)
                                Text(
                                  message.senderName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.blue,
                                  ),
                                ),
                              Text(
                                message.content,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  if (isMe) ...[
                                    const SizedBox(width: 4),
                                    Icon(
                                      message.isRead
                                          ? Icons.done_all
                                          : message.isDelivered
                                          ? Icons.done_all
                                          : Icons.done,
                                      size: 14,
                                      color: message.isRead
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Message Input
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.emoji_emotions_outlined),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.attach_file),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              decoration: const InputDecoration(
                                hintText: 'Message',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                              ),
                              onSubmitted: (_) => _sendMessage(),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.camera_alt),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.accentGreen,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: _messageController.text.isEmpty
                          ? const Icon(Icons.mic, color: Colors.white)
                          : const Icon(Icons.send, color: Colors.white),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}