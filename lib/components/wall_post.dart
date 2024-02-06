import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/components/comment.dart';
import 'package:social_media/components/comment_button.dart';
import 'package:social_media/components/like_button.dart';
import 'package:social_media/helper/helper_methods.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String time;
  final String postId;
  final List<String> likes;
  // final String time;
  const WallPost({
    super.key,
    required this.message,
    required this.user,
    // required this.time,
    required this.postId,
    required this.likes,
    required this.time,
  });

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  // comment text controller
  final _commentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef =
        FirebaseFirestore.instance.collection("User Posts").doc(widget.postId);

    if (isLiked) {
      // add user email to the likes field
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  void addComment(String commentText) {
    FirebaseFirestore.instance
        .collection("User Posts")
        .doc(widget.postId)
        .collection("Comments")
        .add({
      "CommentText": commentText,
      "CommentedBy": currentUser.email,
      "CommentTime": Timestamp.now()
    });
  }

  void showCommentDialog() {
    showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: const Text("Add Comment"),
            content: TextField(
              controller: _commentTextController,
              decoration: InputDecoration(
                  hintText: "Write a comment..",
                  hintStyle: TextStyle(color: Colors.grey[400])),
            ),
            actions: [
              // cancel btn
              TextButton(
                onPressed: () {
                  Navigator.pop(context);

                  _commentTextController.clear();
                },
                child: Text(
                  "Cancel",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.tertiary),
                ),
              ),
              // post btn
              TextButton(
                onPressed: () {
                  addComment(_commentTextController.text);

                  Navigator.pop(context);
                  _commentTextController.clear();
                },
                child: Text(
                  "Post",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.tertiary),
                ),
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // profile pic
          // Container(
          //   decoration:
          //       BoxDecoration(shape: BoxShape.circle, color: Colors.grey[400]),
          //   padding: const EdgeInsets.all(10),
          //   child: const Icon(
          //     Icons.person,
          //     color: Colors.white,
          //   ),
          // ),

          // wallpost
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // message
              Text(widget.message),

              const SizedBox(
                height: 5,
              ),
              // user
              Row(
                children: [
                  Text(
                    widget.user,
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  Text(" . ", style: TextStyle(color: Colors.grey[400])),
                  Text(widget.time, style: TextStyle(color: Colors.grey[400]))
                ],
              ),
            ],
          ),

          const SizedBox(
            height: 20,
          ),

          // btns
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // like
              Column(
                children: [
                  // like btn
                  LikeButton(
                    isLiked: isLiked,
                    onTap: toggleLike,
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  Text(
                    widget.likes.length.toString(),
                    style: const TextStyle(color: Colors.grey),
                  ),

                  // like count
                ],
              ),

              const SizedBox(
                width: 10,
              ),

              // comment
              Column(
                children: [
                  // comment btn
                  CommentButton(
                    onTap: showCommentDialog,
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  const Text(
                    '0',
                    style: TextStyle(color: Colors.grey),
                  ),

                  // like count
                ],
              ),
            ],
          ),

          const SizedBox(
            height: 10,
          ),

          // comments under the post
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("User Posts")
                .doc(widget.postId)
                .collection("Comments")
                .orderBy("CommentTime", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView(
                shrinkWrap: true, //for nested lists
                physics: const NeverScrollableScrollPhysics(),
                children: snapshot.data!.docs.map((doc) {
                  // get the comment
                  final commentData = doc.data() as Map<String, dynamic>;

                  // return\
                  return Comment(
                    text: commentData["CommentText"],
                    user: commentData["CommentedBy"],
                    time: formatDate(commentData["CommentTime"]),
                  );
                }).toList(),
              );
            },
          )
        ],
      ),
    );
  }
}
