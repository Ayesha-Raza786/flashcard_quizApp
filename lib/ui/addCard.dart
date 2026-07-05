import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/flashcard_app_model.dart';
import '../viewModel/flashcard_view.dart';

class CreateCardScreen extends StatefulWidget {
  final Flashcard? flashcard;

  const CreateCardScreen({super.key, this.flashcard});

  @override
  State<CreateCardScreen> createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  @override
  void initState() {
    super.initState();

    if (widget.flashcard != null) {
      questionController.text = widget.flashcard!.question;

      answerController.text = widget.flashcard!.answer;

      selectedTag = widget.flashcard!.tag;
    }
  }

  String selectedTag = "";

  final List<String> tags = [
    "DSA",
    "OOP",
    "Software Engineering",
    "DBMS",
    "AI",
  ];

  final purple = const Color(0xff6200EE);
  final green = const Color(0xff46D9C7);
  final TextEditingController questionController = TextEditingController();

  final TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
       const SizedBox(height: 20),
            Row(
              children: [

                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color(0xff6200EE),
                    size: 30,
                  ),
                ),
                const Text(
                  "FlashFlow",
                  style: TextStyle(
                    color: Color(0xff6200EE),
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              "Create New Card",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              "Fill in the details below to add a new study item to your deck.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),

            const SizedBox(height: 20),

            /// QUESTION CARD
            _buildCard(
              title: "QUESTION",
              titleColor: const Color(0xff6200EE),
              hint: "Enter your question...",
              controller: questionController,
              child: Column(
                children: const [
                  Divider(),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Max 250 characters",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Spacer(),
                      Text(
                        "B",
                        style: TextStyle(
                          color: Color(0xff6200EE),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            /// ANSWER CARD
            _buildCard(
              title: "ANSWER",
              titleColor: const Color(0xff00897B),
              hint: "Enter the answer...",
              controller: answerController,
              child: Column(
                children: [
                  const Divider(),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      /// ADD TAG BUTTON (replaces image button)
                      Expanded(
                        child: GestureDetector(
                          onTap: _openTagBottomSheet,
                          child: _tagButton(
                            icon: Icons.sell_outlined,
                            title: selectedTag.isEmpty
                                ? "Add Tag"
                                : selectedTag,
                            color: green,
                          ),
                        ),
                      ),

                      const SizedBox(width: 15),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const SizedBox(height: 25),

            /// SAVE BUTTON
            SizedBox(
              width: double.infinity,
              height: 65,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                onPressed: () async {
                  if (questionController.text.trim().isEmpty ||
                      answerController.text.trim().isEmpty ||
                      selectedTag.isEmpty) {
                    return;
                  }

                  if (widget.flashcard == null) {
                    // Add new card
                    final flashcard = Flashcard(
                      question: questionController.text.trim(),
                      answer: answerController.text.trim(),
                      tag: selectedTag,
                    );

                    await context.read<FlashcardViewModel>().addFlashcard(flashcard);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Flashcard added successfully!"),
                      ),
                    );

                    questionController.clear();
                    answerController.clear();
                    setState(() => selectedTag = "");

                    // Stay on Create screen after adding
                  } else {
                    // Update existing card
                    final updatedCard = Flashcard(
                      id: widget.flashcard!.id,
                      question: questionController.text.trim(),
                      answer: answerController.text.trim(),
                      tag: selectedTag,
                    );

                    await context.read<FlashcardViewModel>().updateFlashcard(updatedCard);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Flashcard updated successfully!"),
                      ),
                    );

                    Navigator.pop(context); // Go back to FlashFlowScreen
                  }
                },
                icon: const Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                ),
                label: const Text(
                  "Save Card",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔥 TAG BOTTOM SHEET
  void _showTagBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return ListView.builder(
          itemCount: tags.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.label),
              title: Text(tags[index]),
              onTap: () {
                setState(() {
                  selectedTag = tags[index];
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  void _openTagBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 🔥 FIX OVERFLOW
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Select Subject",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                /// TAG LIST
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tags.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.label),
                      title: Text(tags[index]),
                      onTap: () {
                        setState(() {
                          selectedTag = tags[index];
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),

                const Divider(),

                /// ADD NEW TAG BUTTON
                ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text("Add New Tag"),
                  onTap: () {
                    Navigator.pop(context);
                    _showAddTagDialog();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddTagDialog() {
    String newTag = "";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Tag"),
          content: TextField(
            autofocus: true,
            onChanged: (value) => newTag = value,
            decoration: const InputDecoration(hintText: "Enter tag name"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (newTag.trim().isNotEmpty) {
                  setState(() {
                    tags.add(newTag.trim());
                    selectedTag = newTag.trim();
                  });
                }
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  /// CARD WIDGET
  Widget _buildCard({
    required String title,
    required Color titleColor,
    required String hint,
    required Widget child,
    required TextEditingController controller,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.10), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 10),

          TextField(
            controller: controller,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 18),
            ),
          ),

          child,
        ],
      ),
    );
  }

  /// TAG BUTTON UI
  Widget _tagButton({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
