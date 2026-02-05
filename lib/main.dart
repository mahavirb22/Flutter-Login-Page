import 'package:flutter/material.dart';
import 'configurations.dart';
import 'register_page.dart';
import 'utility.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _userID = TextEditingController(), _password = TextEditingController();
  String? _userIDErrorText, _passwordErrorText;

  void validate() {
    bool validated = false;
    setState(() {
      _userIDErrorText = _setUserIDErrorText(_userID.text);
      _passwordErrorText = _setPasswordErrorText(_password.text);
    });
    for (var element in Configurations.credentials) {
      if (element["userid"] == _userID.text &&
          element["password"] == _password.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("Login Approved!"),
          ),
        );
        validated = true;
        break;
      }
    }
    if (!validated) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Login Rejected Check Credentials!"),
        ),
      );
    }
  }

  String? _setUserIDErrorText(String value) {
    if (value.isEmpty) return 'Please enter email ID';
    if (!Utility.validateEmail(value)) return 'Please enter valid email ID';
    return null;
  }

  String? _setPasswordErrorText(String value) {
    if (value.isEmpty) return 'Please enter Password';
    if (!Utility.validatePassword(value)) return 'Please enter valid password';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: _userID,
                builder: (context, value, child) {
                  _userIDErrorText = _setUserIDErrorText(value.text);
                  return TextField(
                    controller: _userID,
                    decoration: InputDecoration(
                      labelText: 'User ID',
                      errorText: _userIDErrorText,
                      hintText: 'dhiraj.jadhav@vit.edu',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                obscureText: true,
                controller: _password,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: _passwordErrorText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            ElevatedButton(onPressed: validate, child: Text('Login')),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}