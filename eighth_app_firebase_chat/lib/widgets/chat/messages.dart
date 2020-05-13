import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapshot.data.documents;
        return ListView.builder(
          itemBuilder: (context, index) => Text(
            chatDocs[index]['text'],
          ),
          itemCount: chatDocs.length,
        );
      },
      stream: Firestore.instance
          .collection('chats/9QaxCbW0kvd3YVDg6bB9/messages')
          .snapshots(),
    );
  }
}
