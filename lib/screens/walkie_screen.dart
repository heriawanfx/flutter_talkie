import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/welcome_screen.dart';
import 'package:myapp/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/components/microphone.dart';
import 'package:myapp/components/recordings_stream.dart';

class WalkieScreen extends StatefulWidget {
  static const String id = 'walkie_screen';

  @override
  _WalkieScreenState createState() => _WalkieScreenState();
}

class _WalkieScreenState extends State<WalkieScreen> {
  bool isRecording = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
        future: FirebaseAuth.instance.currentUser(),
        builder: (context, authSnapshot) {
          if (authSnapshot.hasData) {
            return FutureBuilder<DocumentSnapshot>(
                future: Firestore.instance
                    .collection('users')
                    .document(authSnapshot.data.uid)
                    .get(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.hasData) {
                    return Scaffold(
                      backgroundColor:
                          isRecording ? kColourIsRecording : kColourPrimary,
                      appBar: AppBar(
                        title: Text(kAppTitle, style: kTextStyleAppTitle),
                        automaticallyImplyLeading: false,
                        actions: <Widget>[
                          FlatButton(
                            child:
                                Text('Sign out', style: kTextStyleLogOutButton),
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.pushReplacementNamed(
                                  context, WelcomeScreen.id);
                            },
                          ),
                        ],
                      ),
                      body: SafeArea(
                        child: Container(
                          color: kColourBackground,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              RecordingsStream(),
                              (userSnapshot.data.data['role'] == "admin")
                                  ? Microphone(
                                      isRecording: isRecording,
                                      onStartRecording: () {
                                        setState(() {
                                          isRecording = true;
                                        });
                                      },
                                      onStopRecording: () {
                                        setState(() {
                                          isRecording = false;
                                        });
                                      },
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kColourPrimary),
                      ),
                    );
                  }
                });
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kColourPrimary),
              ),
            );
          }
        });
  }
}
