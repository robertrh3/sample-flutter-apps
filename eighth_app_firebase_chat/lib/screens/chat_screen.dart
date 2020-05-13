import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/chat/messages.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: <Widget>[
          DropdownButton(
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).iconTheme.color,
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(),
            ),
          ],
        ),
      ),
      // StreamBuilder(
      //   builder: (context, streamSnapshot) {
      //     if (streamSnapshot.connectionState == ConnectionState.waiting) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     final documents = streamSnapshot.data.documents;
      //     return ListView.builder(
      //       itemCount: documents.length,
      //       itemBuilder: (context, index) => Container(
      //         padding: EdgeInsets.all(8),
      //         child: Text(documents[index]['text']),
      //       ),
      //     );
      //   },
      //   stream: Firestore.instance
      //       .collection('chats/9QaxCbW0kvd3YVDg6bB9/messages')
      //       .snapshots(),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Firestore.instance
              .collection('chats/9QaxCbW0kvd3YVDg6bB9/messages')
              .add({'text': 'This was added by clicking the button!'});
          // Firestore.instance
          //     .collection('chats/9QaxCbW0kvd3YVDg6bB9/messages')
          //     .snapshots()
          //     .listen((data) {
          //   data.documents.forEach((document) {
          //     print(document['text']);
          // });
          // print(data.documents[0]['text']);
          // });
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
