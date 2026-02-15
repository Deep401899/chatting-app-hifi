import 'package:flutter/material.dart';

import '../models/call_model.dart';
import '../utils/constants.dart';

class CallsScreen extends StatefulWidget {
  const CallsScreen({super.key});

  @override
  State<CallsScreen> createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Call> _allCalls = [];
  final List<Call> _missedCalls = [];
  final List<Call> _favoriteCalls = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadCalls();
  }

  void _loadCalls() {
    // Recent Calls
    _allCalls.addAll([
      Call(
        id: '1',
        contactName: 'suma❤️✨',
        contactImage: '',
        phoneNumber: '+91 9876543210',
        callTime: DateTime.now().subtract(const Duration(hours: 5)),
        type: CallType.missed,
        direction: CallDirection.incoming,
        duration: const Duration(seconds: 0),
        isMissed: true,
        isVideo: false,
      ),
      Call(
        id: '2',
        contactName: 'suma❤️✨',
        contactImage: '',
        phoneNumber: '+91 9876543210',
        callTime: DateTime(2026, 1, 28, 17, 5),
        type: CallType.outgoing,
        direction: CallDirection.outgoing,
        duration: const Duration(minutes: 2, seconds: 30),
        isMissed: false,
        isVideo: false,
      ),
      Call(
        id: '3',
        contactName: 'suma❤️✨',
        contactImage: '',
        phoneNumber: '+91 9876543210',
        callTime: DateTime(2026, 1, 25, 21, 10),
        type: CallType.incoming,
        direction: CallDirection.incoming,
        duration: const Duration(minutes: 5, seconds: 45),
        isMissed: false,
        isVideo: true,
      ),
      Call(
        id: '4',
        contactName: 'suma❤️✨',
        contactImage: '',
        phoneNumber: '+91 9876543210',
        callTime: DateTime(2026, 1, 24, 21, 50),
        type: CallType.outgoing,
        direction: CallDirection.outgoing,
        duration: const Duration(minutes: 1, seconds: 15),
        isMissed: false,
        isVideo: false,
      ),
      Call(
        id: '5',
        contactName: 'suma❤️✨',
        contactImage: '',
        phoneNumber: '+91 9876543210',
        callTime: DateTime(2026, 1, 24, 21, 49),
        type: CallType.missed,
        direction: CallDirection.incoming,
        duration: const Duration(seconds: 0),
        isMissed: true,
        isVideo: true,
      ),
      Call(
        id: '6',
        contactName: 'Kuti',
        contactImage: '',
        phoneNumber: '+91 9876543211',
        callTime: DateTime(2026, 1, 23, 15, 30),
        type: CallType.incoming,
        direction: CallDirection.incoming,
        duration: const Duration(minutes: 10, seconds: 20),
        isMissed: false,
        isVideo: false,
      ),
      Call(
        id: '7',
        contactName: 'Raj Paul',
        contactImage: '',
        phoneNumber: '+91 9876543212',
        callTime: DateTime(2026, 1, 22, 11, 20),
        type: CallType.outgoing,
        direction: CallDirection.outgoing,
        duration: const Duration(minutes: 3, seconds: 45),
        isMissed: false,
        isVideo: true,
      ),
    ]);

    // Missed Calls
    _missedCalls.addAll(_allCalls.where((call) => call.isMissed));

    // Favorite Calls
    _favoriteCalls.addAll([
      Call(
        id: '8',
        contactName: 'Mom',
        contactImage: '',
        phoneNumber: '+91 9876543213',
        callTime: DateTime.now().subtract(const Duration(days: 1)),
        type: CallType.incoming,
        direction: CallDirection.incoming,
        duration: const Duration(minutes: 15, seconds: 30),
        isMissed: false,
        isVideo: false,
      ),
      Call(
        id: '9',
        contactName: 'Dad',
        contactImage: '',
        phoneNumber: '+91 9876543214',
        callTime: DateTime.now().subtract(const Duration(days: 2)),
        type: CallType.outgoing,
        direction: CallDirection.outgoing,
        duration: const Duration(minutes: 8, seconds: 20),
        isMissed: false,
        isVideo: true,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.calls),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Missed'),
            Tab(text: 'Calls'),
            Tab(text: 'Favorites'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // All Tab
          _buildAllCallsTab(),
          // Missed Tab
          _buildMissedCallsTab(),
          // Calls Tab (Schedule/Keypad)
          _buildCallsTab(),
          // Favorites Tab
          _buildFavoritesTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCallOptions(context);
        },
        child: const Icon(Icons.add_call),
      ),
    );
  }

  Widget _buildAllCallsTab() {
    return Column(
      children: [
        // Call Options Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.call, size: 20),
                  label: const Text('Call'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.schedule, size: 20),
                  label: const Text('Schedule'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.dialpad, size: 20),
                  label: const Text('Keypad'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Recent Calls Header
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Clear All',
                style: TextStyle(
                  color: AppColors.primaryGreen,
                ),
              ),
            ],
          ),
        ),

        // Calls List
        Expanded(
          child: ListView.builder(
            itemCount: _allCalls.length,
            itemBuilder: (context, index) {
              final call = _allCalls[index];
              return _buildCallItem(call);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMissedCallsTab() {
    return ListView.builder(
      itemCount: _missedCalls.length,
      itemBuilder: (context, index) {
        final call = _missedCalls[index];
        return _buildCallItem(call);
      },
    );
  }

  Widget _buildCallsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.schedule, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          const Text(
            'No scheduled calls',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              foregroundColor: Colors.white,
            ),
            child: const Text('Schedule a Call'),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesTab() {
    return ListView.builder(
      itemCount: _favoriteCalls.length,
      itemBuilder: (context, index) {
        final call = _favoriteCalls[index];
        return _buildCallItem(call);
      },
    );
  }

  Widget _buildCallItem(Call call) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _getAvatarColor(call.contactName),
        radius: 24,
        child: Text(
          call.contactName.substring(0, 1).toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        call.contactName,
        style: TextStyle(
          fontWeight: call.isMissed ? FontWeight.bold : FontWeight.normal,
          color: call.isMissed ? Colors.red : Colors.black,
        ),
      ),
      subtitle: Row(
        children: [
          Icon(
            call.direction == CallDirection.incoming
                ? Icons.call_received
                : Icons.call_made,
            size: 14,
            color: call.isMissed ? Colors.red : Colors.grey,
          ),
          const SizedBox(width: 4),
          Text(
            _formatCallTime(call.callTime),
            style: TextStyle(
              color: call.isMissed ? Colors.red : Colors.grey,
            ),
          ),
          if (call.duration.inSeconds > 0) ...[
            const Text(' • '),
            Text(
              _formatDuration(call.duration),
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (call.isVideo)
            const Icon(Icons.videocam, color: Colors.grey, size: 20),
          IconButton(
            icon: const Icon(Icons.call, color: AppColors.primaryGreen),
            onPressed: () {
              _makeCall(call);
            },
          ),
        ],
      ),
      onTap: () {
        _showCallDetails(call);
      },
    );
  }

  void _showCallOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.primaryGreen,
                  child: Icon(Icons.add_call, color: Colors.white),
                ),
                title: const Text('New call'),
                onTap: () {
                  Navigator.pop(context);
                  // Start new call
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.primaryGreen,
                  child: Icon(Icons.group_add, color: Colors.white),
                ),
                title: const Text('New group call'),
                onTap: () {
                  Navigator.pop(context);
                  // Start group call
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.primaryGreen,
                  child: Icon(Icons.contacts, color: Colors.white),
                ),
                title: const Text('Add contact'),
                onTap: () {
                  Navigator.pop(context);
                  // Add contact
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _makeCall(Call call) {
    // Implement call functionality
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Call ${call.contactName}'),
        content: Text('Calling ${call.phoneNumber}...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Start call
            },
            child: const Text('Call'),
          ),
        ],
      ),
    );
  }

  void _showCallDetails(Call call) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundColor: _getAvatarColor(call.contactName),
                  radius: 40,
                  child: Text(
                    call.contactName.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  call.contactName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  call.phoneNumber,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.accentGreen,
                        radius: 30,
                        child: IconButton(
                          icon: const Icon(Icons.call, color: Colors.white),
                          onPressed: () => _makeCall(call),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text('Call'),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.primaryGreen,
                        radius: 30,
                        child: IconButton(
                          icon: const Icon(Icons.videocam, color: Colors.white),
                          onPressed: () => _makeVideoCall(call),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text('Video'),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 30,
                        child: IconButton(
                          icon: const Icon(Icons.message, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                            // Navigate to chat
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text('Message'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Call details'),
                subtitle: Text(
                  '${call.direction == CallDirection.incoming ? 'Incoming' : 'Outgoing'} • ${call.isVideo ? 'Video' : 'Voice'} call',
                ),
                trailing: Text(_formatDuration(call.duration)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _makeVideoCall(Call call) {
    // Implement video call functionality
  }

  String _formatCallTime(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final callDay = DateTime(time.year, time.month, time.day);

    final difference = today.difference(callDay).inDays;

    if (difference == 0) {
      return 'Today, ${_formatTime(time)}';
    } else if (difference == 1) {
      return 'Yesterday, ${_formatTime(time)}';
    } else if (difference < 7) {
      return '${_getWeekday(time.weekday)}, ${_formatTime(time)}';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }

  String _formatTime(DateTime time) {
    final hour = time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  String _getWeekday(int weekday) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[weekday - 1];
  }

  String _formatDuration(Duration duration) {
    if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes}m ${duration.inSeconds.remainder(60)}s';
    } else {
      return '${duration.inSeconds}s';
    }
  }

  Color _getAvatarColor(String name) {
    final colors = [
      Colors.redAccent,
      Colors.blueAccent,
      Colors.greenAccent,
      Colors.orangeAccent,
      Colors.purpleAccent,
      Colors.teal,
      Colors.pinkAccent,
    ];
    return colors[name.hashCode % colors.length];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}