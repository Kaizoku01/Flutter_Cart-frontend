import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/data/models/user/user_model.dart';
import 'package:flutter_cart/logic/cubits/user_cubit/user_cubit.dart';
import 'package:flutter_cart/logic/cubits/user_cubit/user_state.dart';
import 'package:flutter_cart/presentation/screens/order/my_orders_screen.dart';
import 'package:flutter_cart/presentation/screens/user/edit_profile.dart';
import 'package:flutter_cart/presentation/widgets/link_button.dart';

import '../../../core/ui.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UserErrorState) {
          return Center(
            child: Text(state.message.toString()),
          );
        }

        if (state is UserLoggedInState) {
          return userProfile(state.userModel);
        }

        return const Center(
          child: Text("An error occured on profile screen"),
        );
      },
    );
  }

  Widget userProfile(UserModel userModel) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${userModel.fullName}',
              style: TextStyles.heading3,
            ),
            Text(
              '${userModel.email}',
              style: TextStyles.body2,
            ),
            LinkButton(
              text: "Edit Profile",
              onPressed: () {
                Navigator.pushNamed(context, EditProfileScreen.routeName);
              },
            )
          ],
        ),
        const Divider(),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(CupertinoIcons.cube_box_fill),
          onTap: () {
            Navigator.pushNamed(context, MyOrderScreen.routeName);
          },
          title: const Text("My Orders"),
        ),

        ListTile(
          onTap: (){
            BlocProvider.of<UserCubit>(context).signOut();
          },
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.exit_to_app, color: Colors.red,),
          title:  Text("Sign Out", style: TextStyles.body1.copyWith(color: Colors.red),),
        )
      ],
    );
  }
}
