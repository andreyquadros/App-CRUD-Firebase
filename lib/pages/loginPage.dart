import 'package:flutter/material.dart';

import '../AppRoutes.dart';
import '../database/DatabaseOperations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        title: Text('Faça seu login', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueAccent,

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                DatabaseOperationsFirebase().signInWithEmailAndPassword(context, _emailController.text, _passwordController.text);
              },
              child: Text('Entrar'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blueAccent, // Cor do texto
                minimumSize: Size(double.infinity, 50), // Largura total e altura adequada
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.signUpPage);
              },
              child: Text('Criar uma nova conta'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.blueAccent, // Cor do texto
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.forgotPage);
              },
              child: Text('Esqueci minha senha'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.blueAccent, // Cor do texto
              ),
            ),
          ],
        ),
      ),
    );

  }
}