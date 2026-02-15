import 'package:flutter/material.dart';

import '../models/status_model.dart';
import '../utils/constants.dart';

class UpdatesScreen extends StatefulWidget {
  const UpdatesScreen({super.key});

  @override
  State<UpdatesScreen> createState() => _UpdatesScreenState();
}

class _UpdatesScreenState extends State<UpdatesScreen> {
  final List<Status> _statuses = [];
  final List<Channel> _channels = [];
  final List<Channel> _suggestedChannels = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    // Statuses
    _statuses.addAll([
      Status(
        id: '1',
        userName: 'My status',
        userImage: '',
        statusText: 'Tap to add status update',
        time: DateTime.now(),
        isMyStatus: true,
      ),
      Status(
        id: '2',
        userName: 'suma 🎉🎉🎉',
        userImage: '',
        statusText: 'Just now',
        time: DateTime.now().subtract(const Duration(minutes: 5)),
        isViewed: false,
      ),
      Status(
        id: '3',
        userName: 'Shangita (Mash Di)',
        userImage: '',
        statusText: 'Today, 10:30 AM',
        time: DateTime.now().subtract(const Duration(hours: 2)),
        isViewed: true,
      ),
      Status(
        id: '4',
        userName: 'Sachin Tendulkar',
        userImage: '',
        statusText: 'Yesterday, 8:15 PM',
        time: DateTime.now().subtract(const Duration(days: 1)),
        isViewed: true,
      ),
    ]);

    // Channels
    _channels.addAll([
      Channel(
        id: '1',
        name: 'Upscale',
        description: 'The channel \'Upscale\' was created',
        imageUrl: '',
        followers: 0,
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
      ),
    ]);

    // Suggested Channels
    _suggestedChannels.addAll([
      Channel(
        id: '2',
        name: 'Who Cares?',
        description: 'Trending topics and discussions',
        imageUrl: '',
        followers: 8800000,
        isFollowing: false,
        createdAt: DateTime.now().subtract(const Duration(days: 365)),
      ),
      Channel(
        id: '3',
        name: 'Health & Fitness',
        description: 'Tips for healthy living',
        imageUrl: '',
        followers: 437000,
        isFollowing: false,
        createdAt: DateTime.now().subtract(const Duration(days: 180)),
      ),
      Channel(
        id: '4',
        name: 'Tamil Nadu Weather',
        description: 'Weather updates for Tamil Nadu',
        imageUrl: '',
        followers: 212000,
        isFollowing: false,
        createdAt: DateTime.now().subtract(const Duration(days: 90)),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.updates),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Section
            _buildStatusSection(),

            // Channels Section
            _buildChannelsSection(),

            // Suggested Channels
            _buildSuggestedChannels(),

            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            backgroundColor: Colors.grey[300],
            onPressed: () {},
            child: const Icon(Icons.edit, color: Colors.black54),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            AppStrings.status,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: _statuses.length,
            itemBuilder: (context, index) {
              final status = _statuses[index];
              return _buildStatusItem(status);
            },
          ),
        ),
        const Divider(height: 20),
      ],
    );
  }

  Widget _buildStatusItem(Status status) {
    return Container(
      width: 80,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: status.isMyStatus
                        ? Colors.grey
                        : status.isViewed
                        ? Colors.grey
                        : AppColors.accentGreen,
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: status.isMyStatus
                      ? Colors.grey[200]
                      : Colors.blue[100],
                  child: status.isMyStatus
                      ? const Icon(Icons.add, size: 30, color: Colors.grey)
                      : Text(
                    status.userName.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              if (status.isMyStatus)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.accentGreen,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            status.userName.split(' ').first,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            status.statusText,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildChannelsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.channels,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Explore',
                  style: TextStyle(color: AppColors.primaryGreen),
                ),
              ),
            ],
          ),
        ),
        ..._channels.map((channel) => _buildChannelItem(channel)).toList(),
        const Divider(height: 20),
      ],
    );
  }

  Widget _buildSuggestedChannels() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Find channels to follow',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ..._suggestedChannels.map((channel) => _buildSuggestedChannelItem(channel)).toList(),
      ],
    );
  }

  Widget _buildChannelItem(Channel channel) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.article_outlined, size: 30, color: Colors.grey),
      ),
      title: Text(
        channel.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        channel.description,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.primaryGreen),
        ),
        child: const Text(
          'Follow',
          style: TextStyle(color: AppColors.primaryGreen),
        ),
      ),
    );
  }

  Widget _buildSuggestedChannelItem(Channel channel) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.orange[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            channel.name.substring(0, 1),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
        ),
      ),
      title: Text(
        channel.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        '${_formatNumber(channel.followers)} followers',
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: channel.isFollowing
          ? OutlinedButton(
        onPressed: () {
          setState(() {
            channel.isFollowing = false;
          });
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey[400]!),
        ),
        child: Text(
          'Following',
          style: TextStyle(color: Colors.grey[700]),
        ),
      )
          : ElevatedButton(
        onPressed: () {
          setState(() {
            channel.isFollowing = true;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: Colors.white,
        ),
        child: const Text('Follow'),
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}