import 'package:emart_app/Constant/MyExport.dart';
import 'package:emart_app/View/SplashScreen/Splash_Screen.dart';

class MyRoutes {
  static String splash = '/';
  static String Login = '/Login';
  static String SignUp = '/SignUP';
  static String Home = '/Home';
  static String Categories = '/Categories';
  static String Cart = '/Cart';
  static String Profile = '/Profile';
}

final getPages = [
  GetPage(
    name: MyRoutes.splash,
    page: () => const Splash_Screen(),
  ),
  GetPage(
    name: MyRoutes.Login,
    page: () => const LoginScreen(),
  ),
  GetPage(
    name: MyRoutes.SignUp,
    page: () => const SignupScreen(),
  ),
  GetPage(
    name: MyRoutes.Home,
    page: () => const Home(),
  ),
  GetPage(
    name: MyRoutes.Categories,
    page: () => const CategoriesScreen(),
  ),
  GetPage(
    name: MyRoutes.Cart,
    page: () => const CartScreen(),
  ),
];
