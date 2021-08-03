import 'package:chat/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt',descending: true).snapshots(),
      builder: (ctx, AsyncSnapshot snapshot) {
        final docs = snapshot.data.docs;
        final user= FirebaseAuth.instance.currentUser;
        return ListView.builder(
          reverse: true,
          itemBuilder: (context, index) => MessageBubble(
              docs[index]['text'],
            docs[index]['userId']==user!.uid,
              docs[index]['username'],

          ),

          itemCount: docs.length,
        );
      },
    );
  }
}
