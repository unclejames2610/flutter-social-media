import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/components/drawer.dart';
import 'package:social_media/components/my_text_field.dart';
import 'package:social_media/components/wall_post.dart';
import 'package:social_media/helper/helper_methods.dart';
import 'package:social_media/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  final textController = TextEditingController();
  // sign user out
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  // post method
  void postMessage() {
    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
        'Likes': [],
      });
    }

    // clear
    setState(() {
      textController.clear();
    });
  }

  void goToProfilePage() {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: MyDrawer(
        onProfiletap: goToProfilePage,
        onSignOut: signOut,
      ),
      appBar: AppBar(
        title: const Text(
          "The Wall",
        ),
        // actions: [
        //   IconButton(
        //     onPressed: signOut,
        //     icon: const Icon(
        //       Icons.logout,
        //       color: Colors.white,
        //     ),
        //   )
        // ],
      ),
      body: Column(
        children: [
          // the wall
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("User Posts")
                  .orderBy(
                    "TimeStamp",
                    descending: false,
                  )
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final post = snapshot.data!.docs[index];
                      return WallPost(
                        message: post['Message'],
                        user: post['UserEmail'],
                        postId: post.id,
                        likes: List<String>.from(post['Likes'] ?? []),
                        time: formatDate(post['TimeStamp']),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          // post message
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                    controller: textController,
                    hintText: "Write something on the wall..",
                    obscureText: false,
                  ),
                ),

                // post button
                Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: IconButton(
                      onPressed: postMessage,
                      icon: const Icon(Icons.arrow_circle_up)),
                )
              ],
            ),
          ),
          // logged in as
          Text(
            "Logged in as: ${currentUser.email!}",
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
