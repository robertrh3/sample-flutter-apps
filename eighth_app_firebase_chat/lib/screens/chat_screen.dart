import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

// iOS push notification permission required prior to firebase notification messages
class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(onMessage: (msg) {
      print(msg);
      return;
    }, onLaunch: (msg) {
      print(msg);
      return;
    }, onResume: (msg) {
      print(msg);
      return;
    });
    // get device token - send notification to a specific device (i.e. two-person chat sends push notification for each participant)
    // fbm.getToken();
    //
    // subscribe to a specific topic - subscribed notifications
    fbm.subscribeToTopic('chats');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: <Widget>[
          DropdownButton(
            underline: Container(),
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
            NewMessage(),
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Firestore.instance
      //         .collection('chats/9QaxCbW0kvd3YVDg6bB9/messages')
      //         .add({'text': 'This was added by clicking the button!'});
      // Firestore.instance
      //     .collection('chats/9QaxCbW0kvd3YVDg6bB9/messages')
      //     .snapshots()
      //     .listen((data) {
      //   data.documents.forEach((document) {
      //     print(document['text']);
      // });
      // print(data.documents[0]['text']);
      // });
      //   },
      //   child: Icon(
      //     Icons.add,
      //   ),
      // ),
    );
  }
}
