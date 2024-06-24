// profile_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_template_simple/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            context.replace('/home'); // 使用replace方法
            await authProvider.logout(); // 登出
          },
          child: const Text('Log Out'),
        ),
      ),
    );
  }
}
