import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  bool isConnected = false;
  bool isConnecting = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleConnection() async {
    if (isConnected) {
      setState(() {
        isConnected = false;
        _animationController.stop();
      });
    } else {
      setState(() {
        isConnecting = true;
        _animationController.repeat();
      });
      
      // Simulate connection delay
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        setState(() {
          isConnecting = false;
          isConnected = true;
          _animationController.stop();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('VPN Yasa', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            _buildStatusText(),
            const SizedBox(height: 60),
            _buildConnectButton(),
            const Spacer(),
            _buildServerSelector(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusText() {
    return Column(
      children: [
        Text(
          isConnected ? 'Bağlantı Kuruldu' : (isConnecting ? 'Bağlanıyor...' : 'Bağlantı Yok'),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isConnected ? 'Güvenli ve Gizli' : 'İnternetiniz korunmuyor',
          style: TextStyle(
            color: isConnected ? Colors.greenAccent : Colors.redAccent,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildConnectButton() {
    return Center(
      child: GestureDetector(
        onTap: isConnecting ? null : _toggleConnection,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isConnected 
                    ? const Color(0xFF1B4965) 
                    : const Color(0xFF1B263B),
                boxShadow: [
                  BoxShadow(
                    color: isConnected 
                        ? Colors.blue.withOpacity(0.5) 
                        : (isConnecting ? Colors.blue.withOpacity(0.3) : Colors.black26),
                    blurRadius: isConnected ? 30 : 10,
                    spreadRadius: isConnected ? 10 : (isConnecting ? 5 * (1 + math.sin(_animationController.value * 2 * math.pi)) : 2),
                  ),
                ],
                border: Border.all(
                  color: isConnected ? Colors.blueAccent : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.power_settings_new,
                  size: 80,
                  color: isConnected ? Colors.blueAccent : (isConnecting ? Colors.white70 : Colors.white54),
                ),
              ),
            );
          }
        ),
      ),
    );
  }

  Widget _buildServerSelector(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/servers');
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1B263B),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white12),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent,
                ),
                child: const Icon(Icons.public, color: Colors.white),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mevcut Sunucu', style: TextStyle(color: Colors.white54, fontSize: 12)),
                    SizedBox(height: 4),
                    Text('Almanya, Frankfurt', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.white54),
            ],
          ),
        ),
      ),
    );
  }
}
