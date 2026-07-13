import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/flashcard_app_model.dart';
import '../viewModel/flashcard_view.dart';
import 'addCard.dart';
import 'cardscreen.dart';
import 'homescreen.dart';

class FlashFlowScreen extends StatefulWidget {
  const FlashFlowScreen({super.key});

  @override
  State<FlashFlowScreen> createState() => _FlashFlowScreenState();
}

class _FlashFlowScreenState extends State<FlashFlowScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<FlashcardViewModel>().loadFlashcards();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardViewModel>(
      builder: (context, vm, child) {
        if (vm.flashcards.isEmpty) {
          return const EmptyFlashcardScreen();
        }

        return Stack(
          children: [
            Container(
              color: const Color(0xFFF7F2FF),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),

                  const Text(
                    "Manage Cards",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff6200EE),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${vm.flashcards.length} flashcards in this deck",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      const Icon(Icons.filter_list, color: Colors.grey),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Expanded(
                    child: ListView.builder(
                      itemCount: vm.flashcards.length,
                      itemBuilder: (context, index) {
                        final card = vm.flashcards[index];

                        return GestureDetector(
                          onTap: () {
                            final vm = context.read<FlashcardViewModel>();

                            vm.selectFlashcard(card);
                            vm.changeTab(0);
                          },
                          child: FlashCardItem(flashcard: card),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class FlashCardItem extends StatelessWidget {
  final Flashcard flashcard;

  const FlashCardItem({super.key, required this.flashcard});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  flashcard.question,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFF3E8FF),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    flashcard.tag,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xff6200EE),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CreateCardScreen(flashcard: flashcard),
                ),
              );
            },
            icon: const Icon(Icons.edit, color: Colors.grey),
          ),

          IconButton(
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Delete Card"),
                  content: const Text(
                    "Are you sure you want to delete this flashcard?",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text("Delete"),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await context.read<FlashcardViewModel>().deleteFlashcard(
                  flashcard.id!,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Flashcard deleted successfully"),
                  ),
                );
              }
            },
            icon: const Icon(Icons.delete, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
