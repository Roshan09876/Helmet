import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helmet/app/app.dart';

void main(){
  runApp(ProviderScope(child: const Myapp()));
}