import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/flashcard_app_model.dart';
import '../viewModel/flashcard_view.dart';

class HomeScreen extends StatefulWidget {
  final Flashcard? flashcard;

  const HomeScreen({super.key, this.flashcard});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showAnswer = false;


  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FlashcardViewModel>();
    final card = vm.selectedFlashcard ??
        Flashcard(
          question: "What is Active Recall?",
          answer:
          "Active recall is a learning technique where you actively retrieve information from memory.",
          tag: "PSYCHOLOGY",
        );
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              const SizedBox(height: 8),

              /// Header
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                  ),
                  const Text(
                    "FlashFlow",
                    style: TextStyle(
                      color: Color(0xFF6A00F4),
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// Progress Row
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "CARD ${vm.currentCardIndex + 1} OF ${vm.flashcards.length}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    vm.flashcards.isEmpty
                        ? "0% Complete"
                        : "${((vm.currentCardIndex + 1) / vm.flashcards.length * 100).toInt()}% Complete",
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6A00F4),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              /// Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: vm.flashcards.isEmpty
                      ? 0
                      : (vm.currentCardIndex + 1) / vm.flashcards.length,
                  minHeight: 5,
                  backgroundColor: const Color(0xFFE7DFF0),
                  valueColor: const AlwaysStoppedAnimation(
                    Color(0xFF6A00F4),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              /// Flash Card
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: const Color(0xFFD8D0DF),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.03),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      /// Edit Button
                      Positioned(
                        right: 12,
                        top: 12,
                        child: Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F1F8),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: const Color(0xFFE1D9E8)),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 18,
                            color: Color(0xFF7E7586),
                          ),
                        ),
                      ),

                      /// Center Content
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                showAnswer ? "ANSWER" : "QUESTION",
                                style: const TextStyle(
                                  letterSpacing: 2.5,
                                  color: Color(0xFF8B5CF6),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                ),
                              ),

                              const SizedBox(height: 30),

                              Text(
                                showAnswer
                                    ? card.answer
                                    : card.question,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 22,
                                  height: 1.15,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF2B2B2B),
                                ),
                              ),

                              const SizedBox(height: 48),

                              // if (!showAnswer) ...[
                              //   const Icon(
                              //     Icons.touch_app_outlined,
                              //     size: 40,
                              //     color: Color(0xFFD5B7FF),
                              //   ),
                              //   const SizedBox(height: 12),
                              //   const Text(
                              //     "TAP TO REVEAL",
                              //     style: TextStyle(
                              //       color: Color(0xFFD5B7FF),
                              //       fontSize: 11,
                              //       fontWeight: FontWeight.w700,
                              //       letterSpacing: 1.5,
                              //     ),
                              //   ),
                              // ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              /// Reveal / Hide Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showAnswer = !showAnswer;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A00F4),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        showAnswer ? "Hide Answer" : "Reveal Answer",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Icon(
                        showAnswer
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    // Previous Button
                    TextButton(
                      onPressed: vm.hasPrevious
                          ? () => vm.previousCard()
                          : null,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.chevron_left,
                            color: vm.hasPrevious
                                ? const Color(0xFF6200EE)
                                : Colors.grey.shade400,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Previous",
                            style: TextStyle(
                              color: vm.hasPrevious
                                  ? const Color(0xFF6200EE)
                                  : Colors.grey.shade400,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Next Button
                    TextButton(
                      onPressed: vm.hasNext
                          ? () => vm.nextCard()
                          : null,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Next",
                            style: TextStyle(
                              color: vm.hasNext
                                  ? const Color(0xFF6200EE)
                                  : Colors.grey.shade400,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.chevron_right,
                            color: vm.hasNext
                                ? const Color(0xFF6200EE)
                                : Colors.grey.shade400,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
