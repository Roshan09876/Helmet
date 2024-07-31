
import 'package:helmet/features/auth/presentation/view/loginview.dart';
import 'package:helmet/features/auth/presentation/view/registerview.dart';
import 'package:helmet/features/dash/presentation/view/helmet_detal.dart';
import 'package:helmet/features/home/presentation/view/home_view.dart';


class AppRoute{
  AppRoute._();

  static const String registerviewRoute = '/registerviewRoute';
  static const String loginRoute = '/loginRoute';
  static const String homeRoute = '/homeRoute';
  static const String helmetDetailRoute = '/helmetDetailRoute';

  
  static getApplicationROute(){
    return {
      registerviewRoute: (context) => const Registerview(),
      loginRoute: (context) => const Loginview(),
      homeRoute: (context) => const HomeView(),
      helmetDetailRoute: (context) => const HelmetDetail(),
    };
  }
}