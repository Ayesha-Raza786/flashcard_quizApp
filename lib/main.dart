import 'package:flashcard_app/ui/addCard.dart';
import 'package:flashcard_app/ui/cardscreen.dart';
import 'package:flashcard_app/ui/cardscreenfull.dart';
import 'package:flashcard_app/ui/homescreen.dart';
import 'package:flashcard_app/viewModel/flashcard_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FlashcardViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // int selectedIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    FlashFlowScreen(),
    CreateCardScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          /// Screens
          Positioned.fill(
            child: Consumer<FlashcardViewModel>(
          builder: (context, vm, child) {
    return IndexedStack(
    index: vm.selectedIndex,
    children: screens,
    );
    },
    ),

            ),
          // ),

          /// Custom Bottom Navigation
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  navItem(
                    icon: Icons.home,
                    index: 0,
                  ),

                  navItem(
                    icon: Icons.style,
                    index: 1,
                  ),

                  navItem(
                    icon: Icons.add,
                    index: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget navItem({
    required IconData icon,
    required int index,
  }) {
    final vm = context.watch<FlashcardViewModel>();

    bool selected = vm.selectedIndex == index;

    return GestureDetector(
      onTap: () {
        context.read<FlashcardViewModel>().changeTab(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? Colors.deepPurple : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          icon,
          color: selected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}