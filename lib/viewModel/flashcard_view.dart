import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/flashcard_app_model.dart';

class FlashcardViewModel extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // List to store all flashcards
  List<Flashcard> _flashcards = [];

  // Loading state
  bool _isLoading = false;
  Flashcard? _selectedFlashcard;
  int _selectedIndex = 0;

  Flashcard? get selectedFlashcard => _selectedFlashcard;
  int get selectedIndex => _selectedIndex;

  // Getters
  List<Flashcard> get flashcards => _flashcards;
  bool get isLoading => _isLoading;

  int _currentCardIndex = -1;

  int get currentCardIndex => _currentCardIndex;
  bool get hasNext =>
      _currentCardIndex < flashcards.length - 1;

  bool get hasPrevious =>
      _currentCardIndex > 0;

  void selectFlashcard(Flashcard card) {
    _selectedFlashcard = card;
    _currentCardIndex = flashcards.indexOf(card);
    notifyListeners();
  }
  void nextCard() {
    if (_currentCardIndex < flashcards.length - 1) {
      _currentCardIndex++;
      _selectedFlashcard = flashcards[_currentCardIndex];
      notifyListeners();
    }
  }
  void previousCard() {
    if (_currentCardIndex > 0) {
      _currentCardIndex--;
      _selectedFlashcard = flashcards[_currentCardIndex];
      notifyListeners();
    }
  }
  void selectFlashcardMethod(Flashcard card) {
    _selectedFlashcard = card;
    notifyListeners();
  }

  void changeTab(int index) {
    _selectedIndex = index;
    notifyListeners();
  }


  // Load all flashcards from database
  Future<void> loadFlashcards() async {
    _isLoading = true;
    notifyListeners();

    _flashcards = await _dbHelper.getFlashcards();

    _isLoading = false;
    notifyListeners();
  }

  // Add new flashcard
  Future<void> addFlashcard(Flashcard flashcard) async {
    await _dbHelper.insertFlashcard(flashcard);

    await loadFlashcards();
  }

  // Update flashcard
  Future<void> updateFlashcard(Flashcard flashcard) async {
    await _dbHelper.updateFlashcard(flashcard);

    await loadFlashcards();
  }

  // Delete flashcard
  Future<void> deleteFlashcard(int id) async {
    await _dbHelper.deleteFlashcard(id);

    await loadFlashcards();
  }

  // Get a flashcard by index
  Flashcard getFlashcard(int index) {
    return _flashcards[index];
  }

  // Total flashcards count
  int get totalCards => _flashcards.length;
}