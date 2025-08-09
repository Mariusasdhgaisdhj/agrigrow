import 'package:flutter/material.dart';

import '../../../widget/page_wrapper.dart';

class ForumPost {
  final String title;
  final String content;
  final String author;
  final DateTime timestamp;

  ForumPost({
    required this.title,
    required this.content,
    required this.author,
    required this.timestamp,
  });
}

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  final List<ForumPost> _posts = [
    ForumPost(
      title: "Welcome to the Community!",
      content: "This is the official community forum. Feel free to share your thoughts!",
      author: "Admin",
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  void _addNewPost(String title, String content) {
    setState(() {
      _posts.add(ForumPost(
        title: title,
        content: content,
        author: "Current User", // In a real app, this would come from auth
        timestamp: DateTime.now(),
      ));
    });
  }

  void _showCreatePostDialog() {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Post'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Post Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
                _addNewPost(titleController.text, contentController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Community Forum"),
          centerTitle: true,
        ),
        body: _posts.isEmpty
            ? Center(
                child: Text(
                  "No posts yet. Be the first to post!",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  final post = _posts[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            post.content,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Posted by ${post.author}',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                              ),
                              Text(
                                '${post.timestamp.toString().substring(0, 16)}',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showCreatePostDialog,
          child: const Icon(Icons.add),
          tooltip: 'Create new post',
        ),
      ),
    );
  }
}