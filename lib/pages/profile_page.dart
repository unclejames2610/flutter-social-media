import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/components/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  // edit field
  Future<void> editField(String field) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: const Text("Profile Page")),
      body: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),

          // profile pic
          Icon(
            Icons.person,
            size: 72,
          ),

          const SizedBox(
            height: 10,
          ),

          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),

          const SizedBox(
            height: 50,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              "My Details",
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),

          MyTextBox(
            text: "ebuka",
            sectionName: 'username',
            onPressed: () => editField('username'),
          ),

          MyTextBox(
            text: "empty bio",
            sectionName: 'bio',
            onPressed: () => editField('bio'),
          ),

          const SizedBox(
            height: 50,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              "My Posts",
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}
