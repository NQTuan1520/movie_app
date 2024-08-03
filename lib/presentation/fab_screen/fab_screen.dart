import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/manager/widget/custom_spin_widget.dart';
import 'package:tuannq_movie/presentation/fab_screen/widget/layout_favorite_widget.dart';
import 'package:tuannq_movie/presentation/fab_screen/widget/layout_guest_widget.dart';

class FabScreen extends StatefulWidget {
  const FabScreen({super.key});

  @override
  State<FabScreen> createState() => _FabScreenState();
}

class _FabScreenState extends State<FabScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SpinCustomWidget(sized: 50.r);
        }

        if (snapshot.hasData) {
          User? user = snapshot.data;

          if (user == null) {
            return const LayoutGuestWidget();
          } else if (user.isAnonymous) {
            return const LayoutGuestWidget();
          } else {
            String uid = user.uid;
            return LayoutFavoriteWidget(uid: uid);
          }
        } else {
          return const LayoutGuestWidget();
        }
      },
    );
  }
}
