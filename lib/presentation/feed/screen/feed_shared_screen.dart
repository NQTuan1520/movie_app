import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/presentation/feed/bloc/shared_bloc/shared_bloc.dart';
import 'package:tuannq_movie/presentation/feed/bloc/shared_bloc/shared_event.dart';
import 'package:tuannq_movie/presentation/feed/widget/layout_feed_widget.dart';
import 'package:tuannq_movie/presentation/feed/widget/layout_guest_widget.dart';

class FeedSharedScreen extends StatefulWidget {
  const FeedSharedScreen({super.key});

  @override
  State<FeedSharedScreen> createState() => _FeedSharedScreenState();
}

class _FeedSharedScreenState extends State<FeedSharedScreen> {
  String uid = '';
  User user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser!;
    uid = user.uid;

    context.read<SharedBloc>().add(const GetAllSharedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return user.isAnonymous
        ? const LayoutAnonymousWidget()
        : LayoutFeedWidget(
            uid: uid,
            user: user,
          );
  }
}
