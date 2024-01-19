import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:flutter_cart/logic/cubits/cart_cubit/cart_state.dart';
import 'package:flutter_cart/logic/cubits/user_cubit/user_cubit.dart';
import 'package:flutter_cart/logic/cubits/user_cubit/user_state.dart';
import 'package:flutter_cart/presentation/screens/cart/cart_screen.dart';
import 'package:flutter_cart/presentation/screens/home/category_screen.dart';
import 'package:flutter_cart/presentation/screens/home/profile_screen.dart';
import 'package:flutter_cart/presentation/screens/home/user_feed_screen.dart';
import 'package:flutter_cart/presentation/splash/splash_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = "home";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> screens = const [
    UserFeedScreen(),
    CategoryScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if(state is UserLoggedOutState){
          Navigator.pushNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Cart'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
              icon: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
                return Badge(
                  label: Text(
                    state.items.length.toString(),
                  ),
                  isLabelVisible: (state is CartLoadingState) ? false : true,
                  child: const Icon(Icons.shopping_cart),
                );
              }),
            ),
          ],
        ),
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
