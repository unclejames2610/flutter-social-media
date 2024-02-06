import 'package:cloud_firestore/cloud_firestore.dart';
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

  // all users
  final usersCollection = FirebaseFirestore.instance.collection("Users");

  // edit field
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Text(
              "Edit $field",
            ),
            content: TextField(
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter new $field",
                hintStyle: const TextStyle(color: Colors.grey),
              ),
              onChanged: (value) {
                newValue = value;
              },
            ),
            actions: [
              // cancel
              TextButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                  onPressed: () => Navigator.of(context).pop()),

              // save
              TextButton(
                  child: Text(
                    'Save',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                  onPressed: () => Navigator.of(context).pop(newValue)),
            ],
          )),
    );

    // update in firestore
    if (newValue.trim().isNotEmpty) {
      await usersCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(title: const Text("Profile Page")),
        body: StreamBuilder<DocumentSnapshot>(
          stream: usersCollection.doc(currentUser.email).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return ListView(
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
                    text: userData['username'],
                    sectionName: 'username',
                    onPressed: () => editField('username'),
                  ),

                  MyTextBox(
                    text: userData['bio'],
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
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error ${snapshot.error}'),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
