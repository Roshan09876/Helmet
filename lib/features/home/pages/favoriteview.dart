import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Favoriteview extends ConsumerStatefulWidget {
  const Favoriteview({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoriteviewState();
}

class _FavoriteviewState extends ConsumerState<Favoriteview> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(child: Text('This is Favorite page'),),
    );
  }
}