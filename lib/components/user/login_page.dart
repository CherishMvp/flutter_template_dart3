// login_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_template_simple/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                print("login.${usernameController.text}");
                print("login.${passwordController.text}");

                try {
                  await authProvider.login(
                    usernameController.text,
                    passwordController.text,
                  );
                } catch (e) {
                  // 处理登录失败
                  print("登录失败${e.toString()}");
                }
              },
              child: const Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}
