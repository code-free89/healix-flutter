import 'package:flutter/material.dart';

class UserInfoProvider extends ChangeNotifier {
  String selectedGender = "";
  String selectedHeightUnit = "CM";
  String selectedWeightUnit = "LB";
  String dob = "";

  void selectGender(String gender) {
    selectedGender = gender;
    notifyListeners();
  }

  void toggleHeightUnit(String unit) {
    selectedHeightUnit = unit;
    notifyListeners();
  }

  void toggleWeightUnit(String unit) {
    selectedWeightUnit = unit;
    notifyListeners();
  }

  void updateDob(String date) {
    dob = date;
    notifyListeners();
  }

  final List<String> healthOptions = [
    "Diabetes",
    "Coronary heart disease (CHD)",
    "Irritable bowel syndrome (IBS)",
    "Obesity",
    "Hypertension",
  ];

  List<bool> selectedHealthConditions =
  List.generate(5, (_) => false); // Initial state

  void toggleHealthCondition(int index) {
    selectedHealthConditions[index] = !selectedHealthConditions[index];
    notifyListeners();
  }

  List<String> getSelectedHealthConditions() {
    return [
      for (int i = 0; i < selectedHealthConditions.length; i++)
        if (selectedHealthConditions[i]) healthOptions[i]
    ];
  }

  List<String> foodOptions = [
  "American",
  "Chinese",
  "Mexican",
  "Thai",
  "Indian",
  "Italian",
  ];

  bool isReordering = false;

  void updateFoodOrder(int oldIndex, int newIndex) {
  isReordering = true;
  if (newIndex > oldIndex) newIndex--;
  final item = foodOptions.removeAt(oldIndex);
  foodOptions.insert(newIndex, item);
  notifyListeners();
  }


  final List<String> _selectedDietary = [];

  List<String> get selectedDietary => _selectedDietary;

  void toggleDietary(String diet) {
    if (_selectedDietary.contains(diet)) {
      _selectedDietary.remove(diet);
    } else {
      _selectedDietary.add(diet);
    }
    notifyListeners();
  }

  void selectAllDietaryOptions() {
    _selectedDietary
      ..clear()
      ..addAll(["Vegetarian", "White meat", "Red meat", "Sea food"]);
    notifyListeners();
  }

  final List<String> allergies = [
    "Milk", "Egg", "Fish", "Wheat", "Shellfish", "Soy beans",
    "Gluten", "Peanuts", "Tree nuts", "Sesame"
  ];

  // Set to store selected allergies
  Set<String> _selectedAllergies = {};

  // Getter for selected allergies
  Set<String> get selectedAllergies => _selectedAllergies;

  // Toggle selection of allergy
  void toggleAllergy(String allergy) {
    if (_selectedAllergies.contains(allergy)) {
      _selectedAllergies.remove(allergy);
    } else {
      _selectedAllergies.add(allergy);
    }
    notifyListeners();
  }

  // Set allergies
  void setAllergies(List<String> allergies) {
    _selectedAllergies = Set.from(allergies);
    notifyListeners();
  }

  void shuffleList() {
    foodOptions.shuffle();
    notifyListeners();
  }

}
