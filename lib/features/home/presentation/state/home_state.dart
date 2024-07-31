import 'package:flutter/material.dart';
import 'package:helmet/features/dash/presentation/view/dashboardview.dart';
import 'package:helmet/features/booked_helmet/cartview.dart';
import 'package:helmet/features/home/pages/profileview.dart';

class HomeState {
  final List<Widget> lstWidget;
  final int index;

  HomeState({
    required this.lstWidget,
    required this.index,
  });

  factory HomeState.initial() {
    return HomeState(
        lstWidget: [DashboardView(), Cartview(), ProfileView()], index: 0);
  }

  //Copy with function
  HomeState copywith({int? index}) {
    return HomeState(lstWidget: lstWidget, index: index ?? this.index);
  }
}
