import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

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
  int _unreadMessages = 0; // Count of unread messages

  Future<void> _openUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  void _incrementUnreadMessages() {
    setState(() {
      _unreadMessages++;
    });
  }

  void _clearUnreadMessages() {
    setState(() {
      _unreadMessages = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.network(
              'https://i.imgur.com/kt5CZ2Q.png',
              height: 50,
              width: 50,
            ),
            const SizedBox(width: 10),
            const Text('Restoration FM'),
          ],
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
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
                MaterialPageRoute(
                    builder: (context) =>
                        ChatRoom(onNewMessage: _incrementUnreadMessages)),
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
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Notifications cleared')),
                  );
                  _clearUnreadMessages(); // Reset unread count
                },
              ),
              if (_unreadMessages > 0)
                Positioned(
                  right: 11,
                  top: 11,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$_unreadMessages',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
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
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://i.imgur.com/EKYwmQQ.png'), // Background image URL
                  fit: BoxFit.cover, // Cover the entire section
                  alignment: Alignment.center, // Align image as needed
                ),
              ),
              child: Container(
                color:
                    Colors.black.withOpacity(0.5), // Semi-transparent overlay
                child: DrawerHeader(
                  decoration: const BoxDecoration(
                    color:
                        Colors.transparent, // Transparent to show the overlay
                  ),
                  padding: EdgeInsets.zero,
                  child: SizedBox.expand(
                    child:
                        Image.network('https://i.imgur.com/sj1lufZ.png', // Logo
                            fit: BoxFit.contain),
                  ),
                ),
              ),
            ),
            Container(
              height: 450, // Height of the container
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://i.imgur.com/EKYwmQQ.png'),
                  fit: BoxFit.cover, // Cover the full container
                  alignment: Alignment.center,
                ),
              ),
              child: Container(
                // Overlay for better contrast
                color:
                    Colors.black.withOpacity(0.7), // Semi-transparent overlay
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.radio, color: Colors.orange),
                      title: const Text(
                        'On Air',
                        style: TextStyle(
                          color: Colors.white, // Make text white for contrast
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () => _openUrl("https://www.restorationfm.com"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.book, color: Colors.green),
                      title: const Text(
                        'Bible',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () => _openUrl(
                          "https://play.google.com/store/apps/details?id=com.flawlessconcepts.mvb_bible&pcampaignid=web_share"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.facebook, color: Colors.blue),
                      title: const Text(
                        'Facebook',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () =>
                          _openUrl("https://Facebook.com/pastorsamuelasiamah"),
                    ),
                    ListTile(
                      leading:
                          const Icon(Icons.telegram, color: Colors.lightBlue),
                      title: const Text(
                        'Telegram',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () => _openUrl("https://t.me/samuelasiamah"),
                    ),
                    ListTile(
                      leading:
                          const Icon(Icons.video_library, color: Colors.red),
                      title: const Text(
                        'YouTube',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () => _openUrl(
                          "https://youtube.com/@pastorsamuelasiamah?si=8OOtPh8kH-HrzbT2"),
                    ),
                    ListTile(
                      leading:
                          const Icon(Icons.contact_phone, color: Colors.purple),
                      title: const Text(
                        'Contact Us',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () => _openUrl("mailto:restorationfmgh@gmail.com"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://i.imgur.com/EKYwmQQ.png'),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to Restoration FM",
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 0),
                  Text(
                    "Restoring Lives through Prayer and God’s Word",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFFFFD700),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logo clicked!')),
                      );
                    },
                    child: Image.network(
                      'https://i.imgur.com/sj1lufZ.png',
                      height: 180,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    _isPlaying ? 'Now Playing: Restoration FM Live' : 'Paused',
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 0),
                  IconButton(
                    icon: Icon(
                      _isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      size: 50,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPlaying = !_isPlaying;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(_isPlaying ? 'Playing' : 'Paused')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChatRoom extends StatefulWidget {
  final VoidCallback onNewMessage;

  const ChatRoom({super.key, required this.onNewMessage});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  String? _userName;
  String? _phoneNumber;
  String _userImageUrl = 'https://via.placeholder.com/150';
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecording = false;
  String? _audioFilePath;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initRecorder();
    WidgetsBinding.instance.addPostFrameCallback((_) => _promptUserInfo());
  }

  Future<void> _initRecorder() async {
    _audioRecorder = FlutterSoundRecorder();
    await _audioRecorder!.openRecorder();
    if (await Permission.microphone.request().isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Microphone permission denied')),
      );
    }
  }

  Future<void> _startRecording() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath =
        '${directory.path}/audio_message_${DateTime.now().millisecondsSinceEpoch}.aac';

    await _audioRecorder!.startRecorder(toFile: filePath);
    setState(() {
      _isRecording = true;
      _audioFilePath = filePath;
    });
  }

  Future<void> _stopRecording() async {
    await _audioRecorder!.stopRecorder();
    setState(() {
      _isRecording = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Recording saved!')),
    );
  }

  void _recordVoice() async {
    if (_isRecording) {
      await _stopRecording();
    } else {
      await _startRecording();
    }
  }

  Future<void> _pickImageOrVideo(ImageSource source, bool isImage) async {
    final pickedFile = await _imagePicker.pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      setState(() {
        _messages.add({
          'name': _userName ?? 'Anonymous',
          'phone': _phoneNumber ?? 'Unknown',
          'message': isImage ? 'Image Message' : 'Video Message',
          'media': pickedFile.path,
        });
      });
    }
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

    if (_audioFilePath != null) {
      setState(() {
        _messages.add({
          'name': _userName ?? 'Anonymous',
          'phone': _phoneNumber ?? 'Unknown',
          'message': 'Audio Message',
          'audio': _audioFilePath!,
        });
        _audioFilePath = null;
      });
    }

    widget.onNewMessage();
  }

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

  @override
  void dispose() {
    _audioRecorder!.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.network(
              'https://i.imgur.com/kt5CZ2Q.png',
              height: 55,
              width: 55,
            ),
            const SizedBox(width: 10),
            const Text('Chatroom'),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://i.imgur.com/EKYwmQQ.png'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    if (message.containsKey('audio')) {
                      return ListTile(
                        leading:
                            const Icon(Icons.audiotrack, color: Colors.white),
                        title: Text('${message['name']} (${message['phone']})'),
                        subtitle: const Text('Audio Message'),
                        trailing: IconButton(
                          icon:
                              const Icon(Icons.play_arrow, color: Colors.white),
                          onPressed: () async {
                            FlutterSoundPlayer player = FlutterSoundPlayer();
                            await player.openPlayer();
                            await player.startPlayer(fromURI: message['audio']);
                          },
                        ),
                      );
                    } else if (message.containsKey('media')) {
                      return ListTile(
                        leading: message['message'] == 'Image Message'
                            ? Image.file(File(message['media']),
                                width: 50, height: 50)
                            : const Icon(Icons.videocam, color: Colors.white),
                        title: Text('${message['name']} (${message['phone']})'),
                        subtitle: Text(message['message']),
                      );
                    }
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: message['image']!.startsWith('http')
                            ? NetworkImage(message['image']!)
                            : FileImage(File(message['image']!))
                                as ImageProvider,
                      ),
                      title: Text(
                        '${message['name']} (${message['phone']})',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        message['message']!,
                        style: const TextStyle(color: Colors.white),
                      ),
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
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        style: const TextStyle(
                          color: Colors.white, // Set to your desired deep color
                          fontSize:
                              16.0, // Optional: Adjust the font size if needed
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(_isRecording ? Icons.stop : Icons.mic,
                          color: Colors.blue),
                      onPressed: _recordVoice,
                    ),
                    IconButton(
                      icon: const Icon(Icons.image, color: Colors.blue),
                      onPressed: () =>
                          _pickImageOrVideo(ImageSource.gallery, true),
                    ),
                    IconButton(
                      icon: const Icon(Icons.videocam, color: Colors.blue),
                      onPressed: () =>
                          _pickImageOrVideo(ImageSource.gallery, false),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.blue),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
