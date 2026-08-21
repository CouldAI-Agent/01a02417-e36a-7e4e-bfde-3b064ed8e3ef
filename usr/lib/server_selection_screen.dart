import 'package:flutter/material.dart';

class ServerSelectionScreen extends StatelessWidget {
  const ServerSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> servers = [
      {'name': 'Almanya, Frankfurt', 'ping': '45ms', 'icon': Icons.public},
      {'name': 'ABD, New York', 'ping': '120ms', 'icon': Icons.public},
      {'name': 'İngiltere, Londra', 'ping': '65ms', 'icon': Icons.public},
      {'name': 'Hollanda, Amsterdam', 'ping': '50ms', 'icon': Icons.public},
      {'name': 'Fransa, Paris', 'ping': '55ms', 'icon': Icons.public},
      {'name': 'Singapur', 'ping': '250ms', 'icon': Icons.public},
      {'name': 'Japonya, Tokyo', 'ping': '280ms', 'icon': Icons.public},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Sunucu Seçimi'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: servers.length,
        itemBuilder: (context, index) {
          final server = servers[index];
          final isSelected = index == 0;
          
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF1B4965) : const Color(0xFF1B263B),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.blueAccent : Colors.transparent,
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: CircleAvatar(
                backgroundColor: isSelected ? Colors.blueAccent : Colors.white12,
                child: Icon(server['icon'], color: Colors.white),
              ),
              title: Text(server['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Ping: ${server['ping']}', style: const TextStyle(color: Colors.white54)),
              trailing: isSelected 
                  ? const Icon(Icons.check_circle, color: Colors.blueAccent)
                  : null,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }
}
