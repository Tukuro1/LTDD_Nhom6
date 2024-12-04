import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'video_screen.dart';
import 'account_screen.dart';
import 'market_screen.dart';

class MainScreen extends StatefulWidget {

  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<String> _videoAssets = [
    'assets/sample_video.mp4',
    'assets/sample_video1.mp4',
    'https://www.youtube.com/watch?v=UmKIIkydLGE',
    'https://www.youtube.com/watch?v=r-Y7hNfqmAg',
  ];

  Color _getIconColor(int index) {
    return _currentIndex == index ? Colors.blue : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
      ),
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _getIconColor(0)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library, color: _getIconColor(1)),
            label: 'Video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: _getIconColor(2)),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: _getIconColor(3)),
            label: 'Market',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        elevation: 10,
      ),
    );
  }

  Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return VideoScreen(videoUrl: _videoAssets[0]); // Hoặc sử dụng video từ danh sách.
      case 2:
        return const AccountScreen();
      case 3:
        return const MarketScreen();
      default:
        return const Center(child: Text('Unknown Screen'));
    }
  }
}
