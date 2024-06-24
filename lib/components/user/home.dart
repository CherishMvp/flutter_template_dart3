// home_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../generated/l10n.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.go('/profile');
              },
              child: const Text('Go to Profile Page'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/detail/123');
              },
              child: const Text('Go to Detail Page with ID 123'),
            ),
          ],
        ),
      ),
    );
  }
}
