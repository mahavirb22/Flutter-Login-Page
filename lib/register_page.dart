import 'package:flutter/material.dart';
import 'configurations.dart';
import 'utility.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _userID = TextEditingController(),
      _password = TextEditingController(),
      _confirmPassword = TextEditingController();
  String? _userIDErrorText, _passwordErrorText;
  String? _setUserIDErrorText(String value) {
    if (value.isEmpty) return 'Please enter email ID';
    if (!Utility.validateEmail(value)) return 'Please enter valid email ID';
    return null;
  }

  String? _setPasswordErrorText(String value) {
    if (value.isEmpty) return 'Please enter Password';
    return null;
  }
  void validate() {
    //validate the page

    setState(() {
      _userIDErrorText = _setUserIDErrorText(_userID.text);
      _passwordErrorText = _setPasswordErrorText(_password.text);
    });
    Configurations.credentials.add({
      'userid': _userID.text,
      'password': _password.text,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Register'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _userID,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                      for (var element in Configurations.credentials) {
                        if (element["userid"] == _userID.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("User Id is taken"),
                            ),
                          );
                          return;
                        }
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text("User Id is available"),
                        ),
                      );
                    },
                    child: Text('Check'),
                  ),
                  labelText: 'User ID',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                obscureText: true,
                controller: _confirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  errorText: _passwordErrorText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            ElevatedButton(onPressed: validate, child: Text('Register')),
          ],
        ),
      ),
    );
  }
}