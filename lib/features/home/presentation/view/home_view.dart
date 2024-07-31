import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helmet/features/home/presentation/view_model/home_view_model.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeviewmodelProvider);
    return Scaffold(
      body: homeState.lstWidget[homeState.index],
      bottomNavigationBar: Container(
        color: Colors.orange,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: GNav(
          backgroundColor: Colors.orange,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: const Color.fromARGB(255, 139, 84, 3),
          gap: 8,
          padding: EdgeInsets.all(16),
          selectedIndex: homeState.index,
          onTabChange: (index) {
            ref.read(homeviewmodelProvider.notifier).changeIndex(index);
          },
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.save,
              text: 'Cart',
            ),
            GButton(
              icon: Icons.verified_user,
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
