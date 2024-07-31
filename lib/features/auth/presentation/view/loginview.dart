
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helmet/app/app_routes.dart';
import 'package:helmet/constants/custom_button.dart';
import 'package:helmet/constants/show_snackbar.dart';
import 'package:helmet/features/auth/service/service.dart';


class Loginview extends ConsumerStatefulWidget {
  const Loginview({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginviewState();
}

final _gap = SizedBox(
  height: 15,
);

bool obscureText = true;
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final Service _Service = Service();
final _key = GlobalKey<FormState>();

void _login(BuildContext context) async {
  if (_key.currentState!.validate()) {
    try {
      final result = await _Service.login(
          _emailController.text.trim(), _passwordController.text.trim());
      print('Login Successfully ${result}');
      showSnackBar(message: 'Login Successfully', context: context);
      Navigator.pushReplacementNamed(context, AppRoute.homeRoute);
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

class _LoginviewState extends ConsumerState<Loginview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 350,
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
            _gap,
            Text(
              'Login',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter email';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(labelText: 'Email'),
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
                          return 'Please Enter password';
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
                              text: 'Login',
                              onPressed: () {
                                _login(context);
                              })),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoute.registerviewRoute);
                      },
                      child: Text(
                        "Dont't have an account?  Register",
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
