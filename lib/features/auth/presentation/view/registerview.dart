import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helmet/app/app_routes.dart';
import 'package:helmet/constants/custom_button.dart';
import 'package:helmet/constants/show_snackbar.dart';
import 'package:helmet/features/auth/service/service.dart';


class Registerview extends ConsumerStatefulWidget {
  const Registerview({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterviewState();
}

final _gap = SizedBox(
  height: 15,
);

bool obscureText = true;
final _key = GlobalKey<FormState>();
final TextEditingController _firstNameController = TextEditingController();
final TextEditingController _lastNameController = TextEditingController();
final TextEditingController _phoneNumController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final Service _Service = Service();

void _register(BuildContext context) async {
  if (_key.currentState!.validate()) {
    try {
      var response = await _Service.register(
          _firstNameController.text.trim(),
          _lastNameController.text.trim(),
          _phoneNumController.text.trim(),
          _emailController.text.trim(),
          _passwordController.text.trim());
      print('Registration successful: $response');
      showSnackBar(message: response['message'], context: context);
      Navigator.pushNamed(context, AppRoute.loginRoute);
    } catch (e) {
      if (e is Exception) {
        showSnackBar(
          color: Colors.red,
            message: e.toString().replaceFirst('Exception: ', ''),
            context: context);
      } else {
        showSnackBar(message: 'An unexpected error occurred', context: context);
      }
    }
  }
}

class _RegisterviewState extends ConsumerState<Registerview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(150))),
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 160,
                  child: Image.asset(
                    'assets/helmet1.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            _gap,
            _gap,
            Text(
              'Please Fill below form to Register',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            _gap,
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(labelText: 'FirstName'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter FirstName';
                        } else {
                          return null;
                        }
                      },
                    ),
                    _gap,
                    TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(labelText: 'LastName'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter LastName';
                        } else {
                          return null;
                        }
                      },
                    ),
                    _gap,
                    TextFormField(
                      controller: _phoneNumController,
                      decoration: InputDecoration(labelText: 'Phone Number'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Phone Numeber';
                        } else {
                          return null;
                        }
                      },
                    ),
                    _gap,
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Email';
                        } else {
                          return null;
                        }
                      },
                    ),
                    _gap,
                    TextFormField(
                      controller: _passwordController,
                      obscureText: obscureText,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              icon: obscureText == true
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Password';
                        } else {
                          return null;
                        }
                      },
                    ),
                    _gap,
                    _gap,
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                              text: 'Register',
                              onPressed: () {
                                _register(context);
                              })),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoute.loginRoute);
                      },
                      child: Text(
                        'Already have an account?  Login',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
