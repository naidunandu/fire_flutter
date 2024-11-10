import 'package:flutter/material.dart';

class NoInternetWidget extends StatefulWidget {
  const NoInternetWidget({super.key});

  @override
  State<NoInternetWidget> createState() => _NoInternetWidgetState();
}

class _NoInternetWidgetState extends State<NoInternetWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off,
              size: 100,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 20),
            const Text(
              'No Internet Connection',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Please check your internet settings and try again.',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
