import 'package:flutter/material.dart';

import '../models/community_model.dart';
import '../utils/constants.dart';

class CommunitiesScreen extends StatefulWidget {
  const CommunitiesScreen({super.key});

  @override
  State<CommunitiesScreen> createState() => _CommunitiesScreenState();
}

class _CommunitiesScreenState extends State<CommunitiesScreen> {
  final List<Community> _communities = [];

  @override
  void initState() {
    super.initState();
    _loadCommunities();
  }

  void _loadCommunities() {
    _communities.addAll([
      Community(
        id: '1',
        name: 'IIT Jodhpur\'s BSc/ BS',
        description: 'Student community',
        imageUrl: '',
        memberCount: 250,
        isAdmin: true,
        announcements: [
          CommunityAnnouncement(
            id: '1',
            title: 'Announcements',
            content: 'Welcome to the community!',
            time: DateTime.now().subtract(const Duration(hours: 5)),
            author: 'Admin',
          ),
          CommunityAnnouncement(
            id: '2',
            title: 'IIT Jodhpur\'s BSc/ BS in Applied AI',
            content: 'Welcome to the group: IIT Jodhpur\'s BSc/BS in Applied AI program discussion',
            time: DateTime.now().subtract(const Duration(hours: 5)),
            author: 'Admin',
          ),
        ],
        groups: [
          CommunityGroup(
            id: '1',
            name: 'General',
            lastMessage: 'Welcome everyone!',
            lastMessageTime: DateTime.now().subtract(const Duration(hours: 5)),
            unreadCount: 3,
          ),
          CommunityGroup(
            id: '2',
            name: 'Study Group',
            lastMessage: 'Assignment discussion at 5 PM',
            lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
            unreadCount: 12,
          ),
        ],
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
      Community(
        id: '2',
        name: 'Shoolini university 2024-27 batch',
        description: 'University batch community',
        imageUrl: '',
        memberCount: 150,
        isArchived: true,
        announcements: [
          CommunityAnnouncement(
            id: '3',
            title: 'You were added',
            content: '',
            time: DateTime(2024, 7, 11),
            author: 'System',
          ),
        ],
        groups: [],
        createdAt: DateTime(2024, 7, 11),
      ),
      Community(
        id: '3',
        name: 'Shoolini University 2024',
        description: 'Official university community',
        imageUrl: '',
        memberCount: 500,
        isArchived: true,
        announcements: [],
        groups: [
          CommunityGroup(
            id: '3',
            name: 'Chatbot Support',
            lastMessage: '+91 95583 53965: Thx bro',
            lastMessageTime: DateTime(2026, 1, 28),
            unreadCount: 0,
          ),
        ],
        createdAt: DateTime(2024, 6, 1),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.communities),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Info Card
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.primaryGreen.withOpacity(0.1),
            child: Row(
              children: [
                const Icon(Icons.groups, color: AppColors.primaryGreen, size: 40),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Stay connected with your communities',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Easily organize related groups and send announcements',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // New Community Button
          ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primaryGreen,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 30),
            ),
            title: const Text(
              'New community',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Create new community
            },
          ),

          const Divider(height: 1),

          // Communities List
          Expanded(
            child: ListView.builder(
              itemCount: _communities.length,
              itemBuilder: (context, index) {
                final community = _communities[index];
                return _buildCommunityItem(community);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new community
        },
        child: const Icon(Icons.groups),
      ),
    );
  }

  Widget _buildCommunityItem(Community community) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Community Header
          ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  community.name.substring(0, 1),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            title: Text(
              community.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${community.memberCount} members'),
            trailing: community.isArchived
                ? const Chip(
              label: Text('Archived'),
              backgroundColor: Colors.grey,
              labelStyle: TextStyle(color: Colors.white, fontSize: 12),
            )
                : community.isAdmin
                ? const Chip(
              label: Text('Admin'),
              backgroundColor: AppColors.primaryGreen,
              labelStyle: TextStyle(color: Colors.white, fontSize: 12),
            )
                : null,
          ),

          // Announcements
          if (community.announcements.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Announcements',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...community.announcements.map((announcement) => _buildAnnouncementItem(announcement)).toList(),
                ],
              ),
            ),

          // Groups
          if (community.groups.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Groups',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      if (community.groups.length > 2)
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'View all',
                            style: TextStyle(color: AppColors.primaryGreen),
                          ),
                        ),
                    ],
                  ),
                  ...community.groups.map((group) => _buildGroupItem(group)).toList(),
                ],
              ),
            ),

          // Divider
          const Divider(height: 1),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.message, size: 20),
                  label: const Text('Message'),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications, size: 20),
                  label: const Text('Mute'),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert, size: 20),
                  label: const Text('More'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementItem(CommunityAnnouncement announcement) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            announcement.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          if (announcement.content.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                announcement.content,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[700],
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              _formatTime(announcement.time),
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[500],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupItem(CommunityGroup group) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.group, size: 20, color: Colors.green),
      ),
      title: Text(
        group.name,
        style: const TextStyle(fontSize: 14),
      ),
      subtitle: Text(
        group.lastMessage,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: group.unreadCount > 0
          ? CircleAvatar(
        radius: 12,
        backgroundColor: AppColors.accentGreen,
        child: Text(
          group.unreadCount > 9 ? '9+' : '${group.unreadCount}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
          : null,
      onTap: () {
        // Navigate to group chat
      },
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }
}