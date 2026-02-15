import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hiffi/screens/calls_screen.dart';
import 'package:hiffi/screens/chat_list_screen.dart';
import 'package:hiffi/screens/communities_screen.dart';
import 'package:hiffi/screens/updates_screen.dart';
import 'package:hiffi/utils/constants.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
        primaryColor: AppColors.primaryGreen,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: AppColors.secondaryGreen,
        ),
        appBarTheme: const AppBarTheme(
          color: AppColors.primaryGreen,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          actionsIconTheme: IconThemeData(color: Colors.white),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.accentGreen,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: AppColors.primaryGreen,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  final List<Widget> _screens = [
    const ChatListScreen(),
    const UpdatesScreen(),
    const CommunitiesScreen(),
    const CallsScreen(),
  ];

  final List<String> _appBarTitles = [
    'Chats',
    'Updates',
    'Communities',
    'Calls',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0
          ? null // ChatListScreen has its own AppBar with tabs
          : AppBar(
        title: Text(_appBarTitles[_currentIndex]),
        actions: _buildAppBarActions(_currentIndex),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  List<Widget> _buildAppBarActions(int index) {
    switch (index) {
      case 0: // Chats
        return [
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            onSelected: (value) {},
            itemBuilder: (BuildContext context) {
              return [
                'New group',
                'New broadcast',
                'Linked devices',
                'Starred messages',
                'Settings',
              ].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ];
      case 1: // Updates
        return [
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ];
      case 2: // Communities
        return [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ];
      case 3: // Calls
        return [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ];
      default:
        return [];
    }
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryGreen,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
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
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}