import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const RadioApp());
}

class RadioApp extends StatelessWidget {
  const RadioApp({super.key});

  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restoration FM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isPlaying = false;

  Future<void> _openUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Row(
    children: [
      Image.network(
        'https://i.imgur.com/kt5CZ2Q.png',
        height: 50, width: 50, // fit app bar
      ),
      const SizedBox(width: 10), // spacing
      const Text('Restoration FM'),
    ],
  ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Opens drawer
              },
            );
          },
        ),
        actions: [
          IconButton(
  icon: Image.network(
      'https://i.imgur.com/AythM1O.png',
    height: 30, 
    width: 40,  
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChatRoom()),
    );
  },
),
          IconButton(
  icon: Image.network(
    'https://i.imgur.com/bO8MSeT.png',
    height: 24,
    width: 24,
  ),
  onPressed: () => _openUrl("https://wa.me/233247080473"),
),

          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notification clicked')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Share clicked')),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              padding: EdgeInsets.zero,
              child: SizedBox.expand(
                child: Image.network(
                  'https://i.imgur.com/rex6hcE.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.radio, color: Colors.orange),
              title: const Text('On Air'),
              onTap: () => _openUrl("https://www.restorationfm.com"),
            ),
            ListTile(
              leading: const Icon(Icons.book, color: Colors.green),
              title: const Text('Bible'),
              onTap: () => _openUrl(
                  "https://play.google.com/store/apps/details?id=com.lifechurch.bible"),
            ),
            ListTile(
              leading: const Icon(Icons.facebook, color: Colors.blue),
              title: const Text('Facebook'),
              onTap: () =>
                  _openUrl("https://web.facebook.com/samuel.n.asiamah"),
            ),
            ListTile(
              leading: const Icon(Icons.telegram, color: Colors.lightBlue),
              title: const Text('Telegram'),
              onTap: () => _openUrl("https://t.me/samuelasiamah"),
            ),
            ListTile(
              leading: const Icon(Icons.video_library, color: Colors.red),
              title: const Text('YouTube'),
              onTap: () => _openUrl(
                  "https://youtube.com/@pastorsamuelasiamah?si=8OOtPh8kH-HrzbT2"),
            ),
            ListTile(
              leading: const Icon(Icons.contact_phone, color: Colors.purple),
              title: const Text('Contact Us'),
              onTap: () => _openUrl("mailto:restorationfmgh@gmail.com"),
            ),
          ],
        ),
      ),
body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logo clicked!')),
          );
        },
        child: Image.network(
          'https://i.imgur.com/kt5CZ2Q.png',
          height: 150,
        ),
      ),
      const SizedBox(height: 20),
      Text(
        _isPlaying ? 'Now Playing: Restoration FM Live' : 'Paused',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 20),
      IconButton(
        icon: Icon(
          _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
          size: 50,
          color: Colors.blue,
        ),
        onPressed: () {
          setState(() {
            _isPlaying = !_isPlaying;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_isPlaying ? 'Playing' : 'Paused')),
          );
        },
      ),
    ],
  ),
),

    );
  }
}
class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  String? _userName;
  String? _phoneNumber;
  String _userImageUrl = 'https://via.placeholder.com/150';

  void _promptUserInfo() async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Your Info'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                ),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                ),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _userName = nameController.text;
                  _phoneNumber = phoneController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add({
          'name': _userName ?? 'Anonymous',
          'phone': _phoneNumber ?? 'Unknown',
          'message': _messageController.text,
          'image': _userImageUrl,
        });
        _messageController.clear();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _promptUserInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Row(
        children: [
          Image.network(
            'https://i.imgur.com/kt5CZ2Q.png', // desired image URL
            height: 30, // size as needed
          ),
          const SizedBox(width: 10), // spacing
          const Text('Chatroom'),
        ],
      ),
    ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(message['image']!),
                  ),
                  title: Text(
                    '${message['name']} (${message['phone']})',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(message['message']!),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.image, color: Colors.blue),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Image icon clicked')),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.videocam, color: Colors.blue),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Video icon clicked')),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.mic, color: Colors.blue),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Voice icon clicked')),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.description, color: Colors.blue),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Document icon clicked')),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.blue),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
