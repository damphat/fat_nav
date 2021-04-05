import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailContoller = TextEditingController();
  final passContoller = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailContoller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    labelText: 'Email',
                    hintText: 'your email',
                    border: OutlineInputBorder(),
                  ),
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: MultiValidator(
                    [
                      RequiredValidator(errorText: ''),
                      EmailValidator(errorText: 'enter a valid email address'),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: passContoller,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline),
                    labelText: 'Password',
                    hintText: 'your password',
                    border: OutlineInputBorder(),
                  ),
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: MultiValidator(
                    [
                      RequiredValidator(errorText: ''),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Create Account'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('login'),
                                  content: Text(
                                      '${emailContoller.text} ${passContoller.text}'),
                                );
                              });
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text('content'),
                                );
                              });
                        }
                      },
                      child: Text('Login'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
