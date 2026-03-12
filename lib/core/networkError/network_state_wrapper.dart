import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fodwa/core/networkError/offline_network.dart';

class NetworkStateWrapper extends StatefulWidget {
  final Widget child;

  const NetworkStateWrapper({Key? key, required this.child}) : super(key: key);

  @override
  _NetworkStateWrapperState createState() => _NetworkStateWrapperState();
}

class _NetworkStateWrapperState extends State<NetworkStateWrapper> {
  bool _isConnected = true;
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  @override
  void initState() {
    super.initState();
    _checkInitialConnection();
    _subscription = Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _checkInitialConnection() async {
    final results = await Connectivity().checkConnectivity();
    _updateConnectionStatus(results);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    bool isConnected = !results.contains(ConnectivityResult.none) && results.isNotEmpty;
    // Handled single none case vs multiple.
    if (results.length == 1 && results.first == ConnectivityResult.none) {
      isConnected = false;
    } else if (results.isNotEmpty && !results.contains(ConnectivityResult.none)) {
      isConnected = true;
    } else {
      // For cases where there are combinations like [wifi, none], if there's any active connection, treat as true
      isConnected = results.any((result) => result != ConnectivityResult.none);
    }
    
    if (_isConnected != isConnected) {
      if (mounted) {
        setState(() {
          _isConnected = isConnected;
        });
      }
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (!_isConnected)
          const Positioned.fill(
            child: OfflineNetwork(),
          ),
      ],
    );
  }
}
