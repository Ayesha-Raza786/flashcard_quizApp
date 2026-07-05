import 'package:flutter/material.dart';

class EmptyFlashcardScreen extends StatelessWidget {
  const EmptyFlashcardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xff6A00F4);
    const bgColor = Color(0xffFAF7FC);

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: bgColor,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              const SizedBox(height: 8),

              /// Header
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back,
                      color: purple,
                      size: 24,
                    ),
                  ),

                  const SizedBox(width: 10),

                  const Text(
                    "FlashFlow",
                    style: TextStyle(
                      color: purple,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const Spacer(),


                ],
              ),

              const SizedBox(height: 80),

              /// Card Icon Container
              Container(
                height: 110,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: purple.withOpacity(.08),
                      blurRadius: 15,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.style_outlined,
                    color: Colors.deepPurple.shade200,
                    size: 36,
                  ),
                ),
              ),

              const SizedBox(height: 80),

              const Text(
                "No Flashcards Yet",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff151515),
                ),
              ),

              const SizedBox(height: 14),

              const SizedBox(
                width: 230,
                child: Text(
                  "Create your first set of cards to get started.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff6B6B6B),
                    height: 1.6,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              /// Add Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purple,
                    elevation: 8,
                    shadowColor: purple.withOpacity(.35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 18,
                  ),
                  label: const Text(
                    "Add Your First Card",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {},
                child: const Text(
                  "IMPORT FROM QUIZLET",
                  style: TextStyle(
                    color: purple,
                    fontSize: 12,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}