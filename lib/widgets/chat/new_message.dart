import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  @override
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final _controller = TextEditingController();
  String _enteredMessage = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send Message...'),
              onChanged: (val) {
                setState(() {
                  _enteredMessage = val;
                });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(3.0),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Theme.of(context).primaryColor,
            ),
            child: IconButton(
              color: Colors.white,
              onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
              icon: Icon(
                Icons.send,
                size: 34.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _sendMessage() async{
    final user= FirebaseAuth.instance.currentUser;
    final userData=await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
    //FocusScope.of(context).unfocus();
    //send Message
    FirebaseFirestore.instance
        .collection('chat')
        .add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'username':userData['username'],
      'userId':user.uid,

        });
    _controller.clear();
  }
}
