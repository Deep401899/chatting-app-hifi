import 'package:flutter/material.dart';
import 'package:hiffi/screens/updates_screen.dart';

import '../models/chat_model.dart';
import '../utils/constants.dart';
import '../widgets/chat_item.dart';
import 'archived_screen.dart';
import 'calls_screen.dart';
import 'chat_detail_screen.dart';
import 'communities_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Chat> _chats = [];
  List<Chat> _pinnedChats = [];
  List<Chat> _archivedChats = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadChats();
  }

  void _loadChats() {
    _chats = [
      Chat(
        id: '1',
        name: 'Kuti',
        lastMessage: '🇮🇳 🌍',
        time: '12:53 pm',
        unreadCount: 0,
        isPinned: true,
        phoneNumber: '+91 9876543210',
      ),
      Chat(
        id: '2',
        name: 'AP Equity Option 🏅🎯📈',
        lastMessage: '+91 90822 17701: angle one 2580...',
        time: '1:00 pm',
        unreadCount: 1,
        isPinned: true,
        isGroup: true,
      ),
      Chat(
        id: '3',
        name: 'Jio Institute',
        lastMessage: 'Dear Aspirant Use your preparatio...',
        time: '11:00 am',
        unreadCount: 2,
      ),
      Chat(
        id: '4',
        name: 'suma💎🌹🌹🌹',
        lastMessage: 'You reacted 😂 to "😘 mil jta he"',
        time: '9:08 am',
        unreadCount: 9,
      ),
      Chat(
        id: '5',
        name: 'IIT Jodhpur\'s BSc/ BS',
        lastMessage: 'IIT Jodhpur\'s BSc/ BS in Applied AI...',
        time: '9:08 am',
        unreadCount: 0,
        isGroup: true,
      ),
      Chat(
        id: '6',
        name: 'Raj Paul',
        lastMessage: 'Inh Onanini: AI Enninar - Huldara',
        time: '9:08 am',
        unreadCount: 0,
      ),
      Chat(
        id: '7',
        name: 'MO - STOCK TRADE IDEAS-6',
        lastMessage: '+91 80971 65731: 📧 MFSL BRE...',
        time: '12:40 pm',
        unreadCount: 187,
        isGroup: true,
      ),
      Chat(
        id: '8',
        name: 'Motilal Oswal Research ✔️',
        lastMessage: '+91 73045 26983: 📧 MFSL BRE...',
        time: '12:40 pm',
        unreadCount: 999,
        isGroup: true,
      ),
      Chat(
        id: '9',
        name: 'Facebook',
        lastMessage: '755889 is your Facebook password...',
        time: 'Yesterday',
        unreadCount: 18,
      ),
    ];

    _pinnedChats = _chats.where((chat) => chat.isPinned).toList();
    _archivedChats = [
      Chat(
        id: '10',
        name: 'Shoolini University 2024-27...',
        lastMessage: '+91 95583 53965: Thx bro',
        time: '28/01/26',
        unreadCount: 16,
        isArchived: true,
      ),
      Chat(
        id: '11',
        name: 'Student support Shoolini O...',
        lastMessage: 'hlo',
        time: '28/01/26',
        unreadCount: 1,
        isArchived: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.camera),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(AppIcons.search),
            onPressed: () => _navigateToSearch(),
          ),
          PopupMenuButton<String>(
            onSelected: _handleMenuSelection,
            itemBuilder: (BuildContext context) {
              return [
                'New group',
                'New broadcast',
                'Linked devices',
                'Starred messages',
                'Settings',
                'Logout'
              ].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'All'),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Unread'),
                  SizedBox(width: 6),
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primaryGreen,
                    child: Text(
                      '8',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Tab(text: 'Favourites'),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Groups'),
                  SizedBox(width: 6),
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primaryGreen,
                    child: Text(
                      '2',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // All Chats Tab
          _buildAllChatsTab(),
          // Unread Tab
          _buildUnreadTab(),
          // Favourites Tab
          _buildFavoritesTab(),
          // Groups Tab
          _buildGroupsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startNewChat,
        child: const Icon(Icons.chat, color: Colors.white),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildAllChatsTab() {
    return ListView(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: AppStrings.askMetaAI,
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ),

        // Pinned Chats
        if (_pinnedChats.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
            child: Text(
              'Pinned',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          ..._pinnedChats.map((chat) => ChatItem(
            chat: chat,
            onTap: () => _openChat(chat),
          )),
          const Divider(height: 1, thickness: 1),
        ],

        // Other Chats
        ..._chats.where((chat) => !chat.isPinned).map((chat) => ChatItem(
          chat: chat,
          onTap: () => _openChat(chat),
        )),

        // Archived Section
        ListTile(
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Icon(
              Icons.archive_outlined,
              color: Colors.grey,
            ),
          ),
          title: const Text(
            'Archived',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '${_archivedChats.length}',
            style: const TextStyle(color: Colors.grey),
          ),
          trailing: const Text(
            '9',
            style: TextStyle(
              color: AppColors.primaryGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: _openArchivedScreen,
        ),
      ],
    );
  }

  Widget _buildUnreadTab() {
    final unreadChats = _chats.where((chat) => chat.unreadCount > 0).toList();
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search unread chats',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ),
        ...unreadChats.map((chat) => ChatItem(
          chat: chat,
          onTap: () => _openChat(chat),
        )),
      ],
    );
  }

  Widget _buildFavoritesTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.star_border, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          const Text(
            'No favourite chats',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Tap and hold on any chat to add it to favourites',
            style: TextStyle(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildGroupsTab() {
    final groupChats = _chats.where((chat) => chat.isGroup).toList();
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search groups',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ),
        ...groupChats.map((chat) => ChatItem(
          chat: chat,
          onTap: () => _openChat(chat),
        )),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      selectedItemColor: AppColors.primaryGreen,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          activeIcon: Icon(Icons.chat),
          label: 'Chats',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.update),
          activeIcon: Icon(Icons.update),
          label: 'Updates',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.groups),
          activeIcon: Icon(Icons.groups),
          label: 'Communities',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.call),
          activeIcon: Icon(Icons.call),
          label: 'Calls',
        ),
      ],
      onTap: (index) {
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UpdatesScreen()),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CommunitiesScreen()),
          );
        } else if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CallsScreen()),
          );
        }
      },
    );
  }

  void _openChat(Chat chat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatDetailScreen(chat: chat),
      ),
    );
  }

  void _openArchivedScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArchivedScreen(chats: _archivedChats),
      ),
    );
  }

  void _navigateToSearch() {
    // Implement search screen navigation
  }

  void _startNewChat() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.accentGreen,
                  child: Icon(Icons.group_add, color: Colors.white),
                ),
                title: const Text('New group'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to create group screen
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.accentGreen,
                  child: Icon(Icons.contact_phone, color: Colors.white),
                ),
                title: const Text('New contact'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to add contact screen
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.accentGreen,
                  child: Icon(Icons.person_add, color: Colors.white),
                ),
                title: const Text('New community'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to create community screen
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleMenuSelection(String value) {
    switch (value) {
      case 'New group':
        _startNewChat();
        break;
      case 'Logout':
      // Implement logout logic
        break;
      default:
      // Handle other menu items
        break;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}