import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helmet/app/app_routes.dart';

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      routes: AppRoute.getApplicationROute(),
      initialRoute: AppRoute.loginRoute,
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
    );
  }
}
